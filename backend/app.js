const express = require('express');
const mysql = require('mysql2/promise');
const cors = require('cors');
const bodyParser = require('body-parser');
const usuariosRouter = require('./src/routes/usuarios');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 3000;

// Configuración de la base de datos (lee las variables de entorno desde .env)
const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

app.use(cors());
app.use(bodyParser.json());

// Rutas de la API (las definiremos más adelante)
app.use('/usuarios', usuariosRouter);
// app.use('/cuentas', cuentasRouter);
// ...

app.listen(port, () => {
  console.log(`Servidor escuchando en el puerto ${port}`);
});