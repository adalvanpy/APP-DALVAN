import 'package:flutter/material.dart';

import 'cotacao_page_base.dart';

class CotacaoTreatPage extends StatelessWidget {
	const CotacaoTreatPage({super.key});

	@override
	Widget build(BuildContext context) {
		final service = CotacaoApiService();

		return CotacaoPage(
			titulo: 'Cotacao do Shiba Inu Treat',
			parMoeda: 'TREAT-BRL',
			chaveResposta: 'TREATBRL',
			cor: Colors.redAccent,
			icone: Icons.account_balance_wallet_outlined,
			moedaPrefixo: 'R\$',
			labelCompra: 'Preco atual',
			labelVenda: 'Mudanca 24h',
			labelMaximo: 'Max. 24h',
			labelMinimo: 'Min. 24h',
			casasDecimais: 8,
			carregarDados: () => service.buscarCotacaoCoinGecko(
				coinId: 'shiba-inu-treat',
				nome: 'Shiba Inu Treat',
			),
		);
	}
}
