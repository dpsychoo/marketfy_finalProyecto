const pool = require("../config/database");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

const determineRole = (email) => {
  if (email.endsWith("@adminMF.com")) return "admin";
  if (email.endsWith("@vendedorMF.com")) return "vendedor";
  return "cliente"; // default
};

const authController = {
  //Registrar user
  async register(req, res) {
    try {
      const { nombre, email, password } = req.body;

      if (!nombre || !email || !password) {
        return res.status(400).json({ message: "Todos los campos son obligatorios." });
      }

      // Determinar el rol automáticamente según el email
      let rol = determineRole(email);
      if (!rol) rol = "cliente"; //Asegurar no null

      // Encriptar contraseña
      const hashedPassword = await bcrypt.hash(password, 10);

      // Ins user en db
      const result = await pool.query(
        "INSERT INTO usuarios (nombre, email, password, rol) VALUES ($1, $2, $3, $4) RETURNING id, nombre, email, rol",
        [nombre, email, hashedPassword, rol]
      );

      const usuario = result.rows[0];

      res.status(201).json({ message: "Usuario registrado exitosamente", user: usuario });
    } catch (error) {
      console.error("Error al registrar usuario:", error);
      res.status(500).json({ message: "Error en el servidor" });
    }
  },

  //Iniciar sesión
  async login(req, res) {
    try {
      const { email, password } = req.body;

      const result = await pool.query("SELECT * FROM usuarios WHERE email = $1", [email]);

      if (result.rows.length === 0) {
        return res.status(401).json({ message: "Credenciales inválidas" }); 
      }

      const usuario = result.rows[0];

      //Verificar pass
      const validPassword = await bcrypt.compare(password, usuario.password);
      if (!validPassword) {
        return res.status(401).json({ message: "Credenciales inválidas" }); 
      }

      //Generar token JWT
      const token = jwt.sign(
        { id: usuario.id, nombre: usuario.nombre, email: usuario.email, rol: usuario.rol },
        process.env.JWT_SECRET,
        { expiresIn: "24h" }
      );

      res.json({ message: "Inicio de sesión exitoso", token, usuario });
    } catch (error) {
      console.error("Error al iniciar sesión:", error);
      res.status(500).json({ message: "Error en el servidor" });
    }
  }
};

module.exports = authController;
