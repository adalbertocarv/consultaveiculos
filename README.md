<p align="center">
  <a href="http://nestjs.com/" target="blank"><img src="https://nestjs.com/img/logo-small.svg" width="200" alt="Nest Logo" /></a>
</p>

[circleci-image]: https://img.shields.io/circleci/build/github/nestjs/nest/master?token=abc123def456
[circleci-url]: https://circleci.com/gh/nestjs/nest

  <p align="center">A progressive <a href="http://nodejs.org" target="_blank">Node.js</a> framework for building efficient and scalable server-side applications.</p>
    <p align="center">
<a href="https://www.npmjs.com/~nestjscore" target="_blank"><img src="https://img.shields.io/npm/v/@nestjs/core.svg" alt="NPM Version" /></a>
<a href="https://www.npmjs.com/~nestjscore" target="_blank"><img src="https://img.shields.io/npm/l/@nestjs/core.svg" alt="Package License" /></a>
<a href="https://www.npmjs.com/~nestjscore" target="_blank"><img src="https://img.shields.io/npm/dm/@nestjs/common.svg" alt="NPM Downloads" /></a>
<a href="https://circleci.com/gh/nestjs/nest" target="_blank"><img src="https://img.shields.io/circleci/build/github/nestjs/nest/master" alt="CircleCI" /></a>
<a href="https://coveralls.io/github/nestjs/nest?branch=master" target="_blank"><img src="https://coveralls.io/repos/github/nestjs/nest/badge.svg?branch=master#9" alt="Coverage" /></a>
<a href="https://discord.gg/G7Qnnhy" target="_blank"><img src="https://img.shields.io/badge/discord-online-brightgreen.svg" alt="Discord"/></a>
<a href="https://opencollective.com/nest#backer" target="_blank"><img src="https://opencollective.com/nest/backers/badge.svg" alt="Backers on Open Collective" /></a>
<a href="https://opencollective.com/nest#sponsor" target="_blank"><img src="https://opencollective.com/nest/sponsors/badge.svg" alt="Sponsors on Open Collective" /></a>
  <a href="https://paypal.me/kamilmysliwiec" target="_blank"><img src="https://img.shields.io/badge/Donate-PayPal-ff3f59.svg"/></a>
    <a href="https://opencollective.com/nest#sponsor"  target="_blank"><img src="https://img.shields.io/badge/Support%20us-Open%20Collective-41B883.svg" alt="Support us"></a>
  <a href="https://twitter.com/nestframework" target="_blank"><img src="https://img.shields.io/twitter/follow/nestframework.svg?style=social&label=Follow"></a>
</p>
  <!--[![Backers on Open Collective](https://opencollective.com/nest/backers/badge.svg)](https://opencollective.com/nest#backer)
  [![Sponsors on Open Collective](https://opencollective.com/nest/sponsors/badge.svg)](https://opencollective.com/nest#sponsor)-->

## Description

[Nest](https://github.com/nestjs/nest) framework TypeScript starter repository.

## Installation

```bash
$ npm install
```

## Running the app

```bash
# development
$ npm run start

# watch mode
$ npm run start:dev

# production mode
$ npm run start:prod
```

## Test

```bash
# unit tests
$ npm run test

# e2e tests
$ npm run test:e2e

# test coverage
$ npm run test:cov
```

## Support

Nest is an MIT-licensed open source project. It can grow thanks to the sponsors and support by the amazing backers. If you'd like to join them, please [read more here](https://docs.nestjs.com/support).

## Stay in touch

- Author - [Kamil Myśliwiec](https://kamilmysliwiec.com)
- Website - [https://nestjs.com](https://nestjs.com/)
- Twitter - [@nestframework](https://twitter.com/nestframework)

## License

Nest is [MIT licensed](LICENSE).

## Projeto Flutter com Node.js e PostgreSQL
Este projeto demonstra como configurar um aplicativo Flutter para consultar um banco de dados PostgreSQL através de uma API backend construída em Node.js. Ele inclui soluções para problemas de CORS ao rodar o Flutter Web e passos para configurar e integrar todos os componentes.

##Configuração do Backend com Node.js e Express
##Passo 1: Criar o Diretório Backend dentro do projeto flutter

```bash

$ mkdir backend
$ cd backend
```

## Passo 2: Inicializar um Projeto Node.js
```bash

$ npm init -y
```

## Passo 3: Instalar Dependências
```bash

$npm install express pg cors
```
## Passo 4: Criar o Arquivo index.js
```bash

touch index.js
```
##Passo 5: Adicionar o Código no Arquivo index.js
```bash
const express = require('express');
const { Pool } = require('pg');
const cors = require('cors');
const app = express();
const port = 3000;
```
## Configurar a conexão com o banco de dados PostgreSQL
``` bash
const pool = new Pool({
user: 'postgres',
host: 'localhost',
database: 'postgres',
password: '022002',
port: 5433,
});
```
## Middleware para habilitar CORS
```bash
app.use(cors());
```
## Middleware para parsing de JSON
``` bash
app.use(express.json());
```
## Rota para consultar o status do veículo
```bash
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
```
##Passo 6: Iniciar o Servidor
```bash

node index.js

```
## Configuração do Frontend Flutter

## Passo 2: Atualizar o pubspec.yaml
## Adicione a dependência http:
``` bash
dependencies:
flutter:
sdk: flutter
http: ^0.13.3
```
## Passo 3: Criar o Arquivo main.dart no Diretório lib

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
```bash

npm install cors
```
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

```bash
cd backend
node index.js
```
Passo 2: Iniciar o Frontend
Navegue para o diretório do projeto Flutter e execute o aplicativo:

```bash
cd frontend
flutter run -d chrome
```
Testar a Aplicação
Insira uma Placa:

Abra o aplicativo no emulador ou dispositivo.
Insira uma placa de veículo que esteja presente no banco de dados, como ABC1234.
Consultar o Status:

Pressione o botão Consultar.
O status do veículo deve ser exibido na tela.
Conclusão
Este documento cobre todos os passos necessários para configurar um aplicativo Flutter que consulta um banco de dados PostgreSQL através de uma API backend em Node.js. Inclui soluções para problemas de CORS e configuração detalhada de cada componente. 
