import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

Future<String?> obterStatusVeiculo(String placaVeiculo, PostgreSQLConnection connection) async {
  var result = await connection.query(
    'SELECT * FROM cco2.public.tb_veiculo WHERE placa = @placa',
    substitutionValues: {'placa': placaVeiculo},
  );

  if (result.isNotEmpty) {
    var valorBooleano = result[0][7];
    return valorBooleano ? "Ativo" : "Inativo";
  } else {
    return null;
  }
}

Future<PostgreSQLConnection?> connectToDatabase() async {
  try {
    var connection = PostgreSQLConnection(
      '10.233.44.28',
      5432,
      'cco2',
      username: 'ADALCSJ',
      password: 'Y3U8V2GmmR',
    );

    await connection.open();
    print("Conexão com o PostgreSQL bem-sucedida!");
    return connection;
  } catch (e) {
    print("Falha ao conectar ao PostgreSQL: $e");
    return null;
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
  PostgreSQLConnection? _connection;

  @override
  void initState() {
    super.initState();
    _initDbConnection();
  }

  Future<void> _initDbConnection() async {
    var connection = await connectToDatabase();
    setState(() {
      _connection = connection;
    });
  }

  Future<void> _consultarStatus() async {
    if (_connection != null) {
      var status = await obterStatusVeiculo(_placaController.text.trim(), _connection!);
      setState(() {
        _statusVeiculo = status ?? "Veículo não encontrado";
      });
    } else {
      setState(() {
        _statusVeiculo = "Falha na conexão com o banco de dados";
      });
    }
  }

  @override
  void dispose() {
    _placaController.dispose();
    _connection?.close();
    super.dispose();
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
