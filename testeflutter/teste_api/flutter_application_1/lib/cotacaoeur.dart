import 'package:flutter/material.dart';

import 'cotacao_page_base.dart';

class CotacaoEurPage extends StatelessWidget {
	const CotacaoEurPage({super.key});

	@override
	Widget build(BuildContext context) {
		return const CotacaoPage(
			titulo: 'Cotacao do Euro',
			parMoeda: 'EUR-BRL',
			chaveResposta: 'EURBRL',
			cor: Colors.blue,
			icone: Icons.euro,
			moedaPrefixo: 'R\$',
		);
	}
}
