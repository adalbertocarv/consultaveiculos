const express = require('express');
const { Pool } = require('pg');
const cors = require('cors');
const app = express();
const port = 3000;

// Configurar a conexão com o banco de dados PostgreSQL
const pool = new Pool({
  user: 'postgres', // substitua pelo seu usuário
  host: 'localhost',
  database: 'postgres', // substitua pelo nome do seu banco de dados
  password: 'senha', // substitua pela sua senha
  port: 5432,
});

// Middleware para habilitar CORS
app.use(cors());

// Middleware para parsing de JSON
app.use(express.json());

// Rota para consultar o status do veículo
app.get('/status-veiculo/:placa', async (req, res) => {
  const { placa } = req.params;
  try {
    const result = await pool.query('SELECT * FROM cco2.public.tb_veiculo WHERE placa = $1', [placa]);
    if (result.rows.length > 0) {
      const valorBooleano = result.rows[0][7]; // A oitava coluna tem índice 7 (0-indexed)
      const status = valorBooleano ? 'Ativo' : 'Inativo';
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
