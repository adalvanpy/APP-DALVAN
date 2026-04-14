import 'package:flutter/material.dart';

import 'cotacaobtc.dart';
import 'cotacaoeur.dart';
import 'cotacaotreat.dart';
import 'cotacaousd.dart';

void main() {
  runApp(const MyApp());
}

class AppRoutes {
  static const home = '/';
  static const usd = '/usd';
  static const eur = '/eur';
  static const btc = '/btc';
  static const treat = '/treat';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Central de Cotacoes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (context) => const CotacaoHome(),
        AppRoutes.usd: (context) => const CotacaoUsdPage(),
        AppRoutes.eur: (context) => const CotacaoEurPage(),
        AppRoutes.btc: (context) => const CotacaoBtcPage(),
        AppRoutes.treat: (context) => const CotacaoTreatPage(),
      },
    );
  }
}

class CotacaoHome extends StatelessWidget {
  const CotacaoHome({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = <_CotacaoCardData>[
      const _CotacaoCardData(
        titulo: 'Dolar',
        subtitulo: 'USD-BRL',
        rota: AppRoutes.usd,
        icone: Icons.attach_money,
        cor: Colors.green,
      ),
      const _CotacaoCardData(
        titulo: 'Euro',
        subtitulo: 'EUR-BRL',
        rota: AppRoutes.eur,
        icone: Icons.euro,
        cor: Colors.blue,
      ),
      const _CotacaoCardData(
        titulo: 'Bitcoin',
        subtitulo: 'BTC-BRL',
        rota: AppRoutes.btc,
        icone: Icons.currency_bitcoin,
        cor: Colors.orange,
      ),
      const _CotacaoCardData(
        titulo: 'Treat',
        subtitulo: 'TREAT-BRL',
        rota: AppRoutes.treat,
        icone: Icons.account_balance_wallet_outlined,
        cor: Colors.redAccent,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Central de Cotacoes'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Escolha uma moeda para consultar os dados em tempo real.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: cards.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.15,
                ),
                itemBuilder: (context, index) {
                  final item = cards[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () => Navigator.pushNamed(context, item.rota),
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            item.cor.withValues(alpha: 0.95),
                            item.cor.withValues(alpha: 0.65),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white.withValues(alpha: 0.18),
                              foregroundColor: Colors.white,
                              child: Icon(item.icone),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.titulo,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.subtitulo,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CotacaoCardData {
  const _CotacaoCardData({
    required this.titulo,
    required this.subtitulo,
    required this.rota,
    required this.icone,
    required this.cor,
  });

  final String titulo;
  final String subtitulo;
  final String rota;
  final IconData icone;
  final Color cor;
}