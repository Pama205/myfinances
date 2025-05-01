const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken'); // Para generar tokens JWT
const pool = require('../config/database'); // Importa la configuración de la base de datos

// --- CRUD de usuarios ---

// Obtener todos los usuarios (solo para administradores)
router.get('/', async (req, res) => {
  // ... (implementar lógica para verificar si el usuario es administrador) ...

  try {
    const [rows] = await pool.query('SELECT id, nombre, email FROM usuarios');
    res.json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ mensaje: 'Error al obtener los usuarios' });
  }
});

// Obtener un usuario por ID (solo para el usuario autenticado o administradores)
router.get('/:id', async (req, res) => {
  const usuarioId = req.params.id;

  // ... (implementar lógica para verificar si el usuario está autenticado y si es administrador o si el ID coincide con el usuario autenticado) ...

  try {
    const [rows] = await pool.query('SELECT id, nombre, email FROM usuarios WHERE id = ?', [usuarioId]);
    if (rows.length === 0) {
      return res.status(404).json({ mensaje: 'Usuario no encontrado' });
    }
    res.json(rows[0]);
  } catch (error) {
    console.error(error);
    res.status(500).json({ mensaje: 'Error al obtener el usuario' });
  }
});

// Crear un nuevo usuario
router.post('/', async (req, res) => {
  try {
    const { nombre, email, contraseña } = req.body;

    // Encriptar la contraseña
    const saltRounds = 10;
    const hashedPassword = await bcrypt.hash(contraseña, saltRounds);

    const [result] = await pool.query(
      'INSERT INTO usuarios (nombre, email, contraseña) VALUES (?, ?, ?)',
      [nombre, email, hashedPassword]
    );

    res.status(201).json({ id: result.insertId, mensaje: 'Usuario creado correctamente' });
  } catch (error) {
    console.error(error);
    if (error.code === 'ER_DUP_ENTRY') {
      return res.status(400).json({ mensaje: 'Ya existe un usuario con ese email' });
    }
    res.status(500).json({ mensaje: 'Error al crear el usuario' });
  }
});

// Actualizar un usuario (solo para el usuario autenticado o administradores)
router.put('/:id', async (req, res) => {
  const usuarioId = req.params.id;
  const { nombre, email } = req.body;

  // ... (implementar lógica para verificar si el usuario está autenticado y si es administrador o si el ID coincide con el usuario autenticado) ...

  try {
    const [result] = await pool.query(
      'UPDATE usuarios SET nombre = ?, email = ? WHERE id = ?',
      [nombre, email, usuarioId]
    );
    if (result.affectedRows === 0) {
      return res.status(404).json({ mensaje: 'Usuario no encontrado' });
    }
    res.json({ mensaje: 'Usuario actualizado correctamente' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ mensaje: 'Error al actualizar el usuario' });
  }
});

// Eliminar un usuario (solo para administradores)
router.delete('/:id', async (req, res) => {
  const usuarioId = req.params.id;

  // ... (implementar lógica para verificar si el usuario es administrador) ...

  try {
    const [result] = await pool.query('DELETE FROM usuarios WHERE id = ?', [usuarioId]);
    if (result.affectedRows === 0) {
      return res.status(404).json({ mensaje: 'Usuario no encontrado' });
    }
    res.json({ mensaje: 'Usuario eliminado correctamente' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ mensaje: 'Error al eliminar el usuario' });
  }
});


// --- Login ---

router.post('/login', async (req, res) => {
  try {
    const { email, contraseña } = req.body;

    const [rows] = await pool.query('SELECT * FROM usuarios WHERE email = ?', [email]);
    if (rows.length === 0) {
      return res.status(401).json({ mensaje: 'Credenciales inválidas' });
    }

    const usuario = rows[0];
    const match = await bcrypt.compare(contraseña, usuario.contraseña);
    if (!match) {
      return res.status(401).json({ mensaje: 'Credenciales inválidas' });
    }

    // Generar un token JWT
    const token = jwt.sign({ id: usuario.id }, process.env.JWT_SECRET, { expiresIn: '1h' });

    res.json({ token });
  } catch (error) {
    console.error(error);
    res.status(500).json({ mensaje: 'Error al iniciar sesión' });
  }
});

module.exports = router;