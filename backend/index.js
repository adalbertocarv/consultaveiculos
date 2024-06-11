const express = require('express');
const { Pool } = require('pg');
const cors = require('cors');
const app = express();
const port = 3000;

const pool = new Pool({
  user: 'usuario',
  host: 'hostname',
  database: 'banco',
  password: 'senha',
  port: 5432,
});

app.use(cors());
app.use(express.json());

app.get('/status-veiculo/:placa', async (req, res) => {
  const { placa } = req.params;
  try {
    const result = await pool.query('SELECT * FROM cco2.public.tb_veiculo WHERE placa = $1', [placa]);
    if (result.rows.length > 0) {
      const valorBooleano = result.rows[0][7];
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
