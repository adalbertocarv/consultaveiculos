import 'package:postgres/postgres.dart';

Future<String?> obterStatusVeiculo(String placaVeiculo, PostgreSQLConnection connection) async {
  /*
   Obtém o valor da oitava coluna para uma linha específica com base na coluna "placa" e converte o valor booleano em string correspondente ("Ativo" ou "Inativo").

   Args:
       placa_veiculo (str): Placa do veículo a ser consultado.
       connection: Objeto de conexão ao banco de dados PostgreSQL.

   Returns:
       str: "Ativo" se a oitava coluna for True, "Inativo" se for False, None se o veículo não for encontrado.
  */
  var result = await connection.query(
    'SELECT * FROM cco2.public.tb_veiculo WHERE placa = @placa',
    substitutionValues: {
      'placa': placaVeiculo,
    },
  );

  if (result.isNotEmpty) {
    var valorBooleano = result[0][7];  // A oitava coluna tem índice 7 (0-indexed)
    return valorBooleano ? "Ativo" : "Inativo";
  } else {
    return null;
  }
}

Future<PostgreSQLConnection?> connectToDatabase() async {
  /*
   Conecta ao banco de dados PostgreSQL e retorna um objeto de conexão.

   Returns:
       connection: Objeto de conexão ao banco de dados.
  */
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

void main() async {
  var connection = await connectToDatabase();

  if (connection != null) {
    var placaVeiculo = "OVO1648 ";
    var statusVeiculo = await obterStatusVeiculo(placaVeiculo, connection);

    if (statusVeiculo != null) {
      print("O veículo com a placa $placaVeiculo está $statusVeiculo.");
    } else {
      print("O veículo com a placa $placaVeiculo não foi encontrado.");
    }

    await connection.close();
  } else {
    print("Falha ao conectar ao banco de dados!");
  }
}
