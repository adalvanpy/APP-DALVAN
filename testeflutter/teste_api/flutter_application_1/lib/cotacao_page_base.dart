import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CotacaoDados {
  const CotacaoDados({
    required this.compra,
    required this.venda,
    required this.maximo,
    required this.minimo,
    required this.variacao,
    required this.nome,
  });

  final double compra;
  final double venda;
  final double maximo;
  final double minimo;
  final double variacao;
  final String nome;
}

class CotacaoApiService {
  Future<CotacaoDados> buscarCotacao(String parMoeda, String chaveResposta) async {
    final response = await http.get(
      Uri.parse('https://economia.awesomeapi.com.br/json/last/$parMoeda'),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao carregar a cotacao de $parMoeda.');
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final data = body[chaveResposta] as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('Resposta invalida para $parMoeda.');
    }

    return CotacaoDados(
      compra: double.parse(data['bid'] as String),
      venda: double.parse(data['ask'] as String),
      maximo: double.parse(data['high'] as String),
      minimo: double.parse(data['low'] as String),
      variacao: double.parse(data['pctChange'] as String),
      nome: data['name'] as String? ?? parMoeda,
    );
  }

  Future<CotacaoDados> buscarCotacaoCoinGecko({
    required String coinId,
    required String nome,
  }) async {
    final response = await http.get(
      Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=brl&ids=$coinId',
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao carregar a cotacao de $nome no CoinGecko.');
    }

    final body = jsonDecode(response.body) as List<dynamic>;
    if (body.isEmpty) {
      throw Exception('Moeda $nome nao encontrada no CoinGecko.');
    }

    final data = body.first as Map<String, dynamic>;
    final currentPrice = (data['current_price'] as num?)?.toDouble();
    final high24h = (data['high_24h'] as num?)?.toDouble();
    final low24h = (data['low_24h'] as num?)?.toDouble();
    final priceChange24h = (data['price_change_24h'] as num?)?.toDouble();
    final priceChangePercentage24h =
        (data['price_change_percentage_24h'] as num?)?.toDouble();

    if (currentPrice == null ||
        high24h == null ||
        low24h == null ||
        priceChange24h == null ||
        priceChangePercentage24h == null) {
      throw Exception('Resposta incompleta do CoinGecko para $nome.');
    }

    return CotacaoDados(
      compra: currentPrice,
      venda: priceChange24h,
      maximo: high24h,
      minimo: low24h,
      variacao: priceChangePercentage24h,
      nome: data['name'] as String? ?? nome,
    );
  }
}

class CotacaoPage extends StatefulWidget {
  const CotacaoPage({
    super.key,
    required this.titulo,
    required this.parMoeda,
    required this.chaveResposta,
    required this.cor,
    required this.icone,
    required this.moedaPrefixo,
    this.labelCompra = 'Compra',
    this.labelVenda = 'Venda',
    this.labelMaximo = 'Maximo',
    this.labelMinimo = 'Minimo',
    this.casasDecimais = 2,
    this.carregarDados,
  });

  final String titulo;
  final String parMoeda;
  final String chaveResposta;
  final Color cor;
  final IconData icone;
  final String moedaPrefixo;
  final String labelCompra;
  final String labelVenda;
  final String labelMaximo;
  final String labelMinimo;
  final int casasDecimais;
  final Future<CotacaoDados> Function()? carregarDados;

  @override
  State<CotacaoPage> createState() => _CotacaoPageState();
}

class _CotacaoPageState extends State<CotacaoPage> {
  late Future<CotacaoDados> _future;
  final CotacaoApiService _service = CotacaoApiService();

  @override
  void initState() {
    super.initState();
    _future = _carregarDados();
  }

  void _recarregar() {
    setState(() {
      _future = _carregarDados();
    });
  }

  Future<CotacaoDados> _carregarDados() {
    final carregarDados = widget.carregarDados;
    if (carregarDados != null) {
      return carregarDados();
    }

    return _service.buscarCotacao(widget.parMoeda, widget.chaveResposta);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
        centerTitle: true,
      ),
      body: FutureBuilder<CotacaoDados>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error_outline, size: 56, color: widget.cor),
                    const SizedBox(height: 12),
                    Text(
                      'Nao foi possivel atualizar a cotacao.',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: _recarregar,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Tentar novamente'),
                    ),
                  ],
                ),
              ),
            );
          }

          final dados = snapshot.data;
          if (dados == null) {
            return const Center(child: Text('Sem dados para exibir.'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              _recarregar();
              await _future;
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      colors: [
                        widget.cor.withValues(alpha: 0.9),
                        widget.cor.withValues(alpha: 0.6),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(widget.icone, color: Colors.white, size: 34),
                      const SizedBox(height: 16),
                      Text(
                        dados.nome,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Variacao do dia: ${dados.variacao.toStringAsFixed(2)}%',
                        style: const TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.0,
                  children: [
                    _InfoCard(
                      titulo: widget.labelCompra,
                      valor:
                          '${widget.moedaPrefixo} ${dados.compra.toStringAsFixed(widget.casasDecimais)}',
                      icone: Icons.south_west,
                      cor: widget.cor,
                    ),
                    _InfoCard(
                      titulo: widget.labelVenda,
                      valor:
                          '${widget.moedaPrefixo} ${dados.venda.toStringAsFixed(widget.casasDecimais)}',
                      icone: Icons.north_east,
                      cor: widget.cor,
                    ),
                    _InfoCard(
                      titulo: widget.labelMaximo,
                      valor:
                          '${widget.moedaPrefixo} ${dados.maximo.toStringAsFixed(widget.casasDecimais)}',
                      icone: Icons.arrow_upward,
                      cor: Colors.green,
                    ),
                    _InfoCard(
                      titulo: widget.labelMinimo,
                      valor:
                          '${widget.moedaPrefixo} ${dados.minimo.toStringAsFixed(widget.casasDecimais)}',
                      icone: Icons.arrow_downward,
                      cor: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _recarregar,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.titulo,
    required this.valor,
    required this.icone,
    required this.cor,
  });

  final String titulo;
  final String valor;
  final IconData icone;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: cor.withValues(alpha: 0.12),
              foregroundColor: cor,
              child: Icon(icone),
            ),
            Text(
              titulo,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              valor,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}