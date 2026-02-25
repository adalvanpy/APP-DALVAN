import 'package:flutter/material.dart';

void main() {
  runApp(MyApp(
    title: 'Reflexao',
    home: Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 125, 249, 255),
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Nome: ADALVAN'),
              const SizedBox(height: 8),
              const Text('Cidade: ARACI - BAHIA'),
              const SizedBox(height: 8),
              const Text('Frase: SOU INTEGRO E AUTÊNTICO COMIGO MESMO, SEM PERDER A CAPACIDADE DE ME ADAPTAR A QUALQUER AMBIENTE.'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  print('Botao pressionado');
                },
                child: const Text('Clique aqui'),
              ),
            ],
          ),
        ),
      ),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.title, required this.home});

  final String title;
  final Widget home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: home,
    );
  }
}
