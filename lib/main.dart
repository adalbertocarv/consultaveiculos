import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String?> obterStatusVeiculo(String placaVeiculo) async {
  try {
    final response = await http.get(Uri.parse('http://seuipv4:3000/vehicle/$placaVeiculo'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['status'];
    } else if (response.statusCode == 404) {
      return 'Veículo não encontrado';
    } else {
      return 'Erro ao consultar o banco de dados';
    }
  } catch (e) {
    print('Erro ao fazer a solicitação: $e');
    return 'Erro ao fazer a solicitação';
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _placaController = TextEditingController();
  String? _statusVeiculo;

  Future<void> _consultarStatus() async {
    var status = await obterStatusVeiculo(_placaController.text.trim());
    setState(() {
      _statusVeiculo = status ?? "Erro ao consultar o banco de dados";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/onibus.png', // Certifique-se de ter uma imagem de ônibus em assets/bus.png
              height: 300,
            ),
            SizedBox(height: 20),
            Text(
              '🔍 Pesquise o status do ônibus',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _placaController,
              decoration: InputDecoration(
                labelText: 'Placa do Veículo',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.directions_bus),
              ),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _consultarStatus,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 20),
              ),
              child: Text('Consultar 🔍'),
            ),
            SizedBox(height: 20),
            if (_statusVeiculo != null) ...[
              Text(
                'Status: $_statusVeiculo',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
