import 'package:flutter/material.dart';

import 'cotacao_page_base.dart';

class CotacaoUsdPage extends StatelessWidget {
	const CotacaoUsdPage({super.key});

	@override
	Widget build(BuildContext context) {
		return const CotacaoPage(
			titulo: 'Cotacao do Dolar',
			parMoeda: 'USD-BRL',
			chaveResposta: 'USDBRL',
			cor: Colors.green,
			icone: Icons.attach_money,
			moedaPrefixo: 'R\$',
		);
	}
}
