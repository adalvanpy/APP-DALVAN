import 'package:flutter/material.dart';

import 'cotacao_page_base.dart';

class CotacaoBtcPage extends StatelessWidget {
	const CotacaoBtcPage({super.key});

	@override
	Widget build(BuildContext context) {
		return const CotacaoPage(
			titulo: 'Cotacao do Bitcoin',
			parMoeda: 'BTC-BRL',
			chaveResposta: 'BTCBRL',
			cor: Colors.orange,
			icone: Icons.currency_bitcoin,
			moedaPrefixo: 'R\$',
		);
	}
}
