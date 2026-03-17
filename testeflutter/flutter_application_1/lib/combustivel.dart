import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: CalculoGasolina(),
  ));
}

class CalculoGasolina extends StatefulWidget {
  @override
  _CalculoGasolinaState createState() => _CalculoGasolinaState();
}

class _CalculoGasolinaState extends State<CalculoGasolina> {
  String? gasolina;
  String? etanol;
  String resultado = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculo Gasolina x Etanol'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Digite o preco da gasolina',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (valor) {
                gasolina = valor;
              },
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Digite o preco do etanol',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (valor) {
                etanol = valor;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (gasolina != null && etanol != null) {
                  double gas = double.parse(gasolina!);
                  double eta = double.parse(etanol!);
                  
                  setState(() {
                    if (eta < gas) {
                      resultado = 'Abasteça com etanol!';
                    } else {
                      resultado = 'Abasteça com gasolina!';
                    }
                  });
                }
              },
              child: Text('Calcular'),
            ),
            SizedBox(height: 20),
            Text(
              resultado,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}