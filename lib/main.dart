import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String?> obterStatusVeiculo(String placaVeiculo) async {
  try {
    final response = await http.get(Uri.parse('http://localhost:3000/vehicle/$placaVeiculo'));

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
      appBar: AppBar(
        title: Text('Consulta de Veículo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _placaController,
              decoration: InputDecoration(
                labelText: 'Placa do Veículo',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _consultarStatus,
              child: Text('Consultar'),
            ),
            SizedBox(height: 20),
            if (_statusVeiculo != null) ...[
              Text(
                'Status: $_statusVeiculo',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
