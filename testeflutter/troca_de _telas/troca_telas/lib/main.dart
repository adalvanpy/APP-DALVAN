import 'package:flutter/material.dart';
import 'alimentos.dart';
import 'contato.dart';
import 'inicio.dart';
import 'mais.dart';
import 'sobre.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const InicioPage(),
      initialRoute: "/",
      routes: {
        "/alimentos": (context) => const AlimentosPage(),
        "/contato": (context) => const ContatoPage(),
        "/sobre": (context) => const SobrePage(),
        "/mais": (context) => const MaisPage(),
      },
    );
  }
}