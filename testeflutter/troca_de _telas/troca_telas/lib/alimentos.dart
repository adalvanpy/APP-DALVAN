import 'package:flutter/material.dart';

class AlimentosPage extends StatelessWidget {
	const AlimentosPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Alimentos'),
			),
			body: Center(
				child: ElevatedButton.icon(
					onPressed: () => Navigator.pop(context),
					icon: const Icon(Icons.arrow_back),
					label: const Text('Voltar'),
				),
			),
		);
	}
}
