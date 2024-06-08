Projeto Flutter com Node.js e PostgreSQL
Este projeto demonstra como configurar um aplicativo Flutter para consultar um banco de dados PostgreSQL através de uma API backend construída em Node.js. Ele inclui soluções para problemas de CORS ao rodar o Flutter Web e passos para configurar e integrar todos os componentes.

Configuração do Backend com Node.js e Express
Passo 1: Criar o Diretório Backend dentro do projeto flutter

bash

mkdir backend
cd backend

Passo 2: Inicializar um Projeto Node.js
bash

npm init -y

Passo 3: Instalar Dependências
bash

npm install express pg cors

Passo 4: Criar o Arquivo index.js
bash

touch index.js

Passo 5: Adicionar o Código no Arquivo index.js

const express = require('express');
const { Pool } = require('pg');
const cors = require('cors');
const app = express();
const port = 3000;

// Configurar a conexão com o banco de dados PostgreSQL
const pool = new Pool({
user: 'postgres',
host: 'localhost',
database: 'postgres',
password: '022002',
port: 5433,
});

// Middleware para habilitar CORS
app.use(cors());

// Middleware para parsing de JSON
app.use(express.json());

// Rota para consultar o status do veículo
app.get('/status-veiculo/:placa', async (req, res) => {
const { placa } = req.params;
try {
const result = await pool.query('SELECT ativo FROM cco2.tb_veiculo WHERE placa = $1', [placa]);
if (result.rows.length > 0) {
const status = result.rows[0].ativo ? 'Ativo' : 'Inativo';
res.json({ status });
} else {
res.status(404).json({ error: 'Veículo não encontrado' });
}
} catch (err) {
console.error(err);
res.status(500).json({ error: 'Erro ao consultar o banco de dados' });
}
});

app.listen(port, () => {
console.log(`Servidor rodando em http://localhost:${port}`);
});

Passo 6: Iniciar o Servidor
bash

node index.js


Configuração do Frontend Flutter

Passo 2: Atualizar o pubspec.yaml
Adicione a dependência http:

dependencies:
flutter:
sdk: flutter
http: ^0.13.3

Passo 3: Criar o Arquivo main.dart no Diretório lib

Solução de Problemas
Problema: "Cannot GET /"
Erro: A mensagem "Cannot GET /" indica que você acessou a raiz do servidor ("/") e não há uma rota definida para essa URL.

Solução:

Certifique-se de que você está acessando a rota correta http://localhost:3000/status-veiculo/:placa no seu aplicativo Flutter ou no navegador.
Problema: "XMLHttpRequest error."
Erro: O erro "XMLHttpRequest error" ocorre quando o navegador impede a solicitação devido a problemas de CORS ou porque o servidor não está acessível a partir do navegador.

Solução:

Habilitar CORS no Backend:
Instale o middleware cors e configure-o no seu servidor Node.js.
bash

npm install cors

Remover o arquivo flutter_tools.stamp:
Navegue para o diretório flutter\bin\cache e remova o arquivo flutter_tools.stamp.

Editar o arquivo chrome.dart:
Abra o arquivo chrome.dart localizado em flutter\packages\flutter_tools\lib\src\web\chrome.dart.
Localize a linha contendo '--disable-extensions' e adicione '--disable-web-security' logo após ela.

List<String> args = <String>[
'--disable-extensions',
'--disable-web-security',
// outras opções
];

Certifique-se de que a URL do Flutter Web está correta:
Se você estiver rodando o Flutter Web, use o endereço IP da sua máquina em vez de localhost.
Executar o Projeto
Passo 1: Iniciar o Backend
Certifique-se de que o backend está rodando:

bash
cd backend
node index.js

Passo 2: Iniciar o Frontend
Navegue para o diretório do projeto Flutter e execute o aplicativo:

bash
cd frontend
flutter run -d chrome
Testar a Aplicação
Insira uma Placa:

Abra o aplicativo no emulador ou dispositivo.
Insira uma placa de veículo que esteja presente no banco de dados, como ABC1234.
Consultar o Status:

Pressione o botão Consultar.
O status do veículo deve ser exibido na tela.
Conclusão
Este documento cobre todos os passos necessários para configurar um aplicativo Flutter que consulta um banco de dados PostgreSQL através de uma API backend em Node.js. Inclui soluções para problemas de CORS e configuração detalhada de cada componente. 