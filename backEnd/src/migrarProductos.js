const fs = require("fs");
const path = require("path");
const pool = require("./config/database");


const productosPath = path.join(__dirname, "../../frontEnd/src/data/productos.json");


const productos = JSON.parse(fs.readFileSync(productosPath, "utf-8"));

// Función para obtener un usuario vendedor existente o crear uno
const obtenerVendedor = async () => {
  try {
    let resultado = await pool.query("SELECT id FROM usuarios WHERE rol = 'vendedor' LIMIT 1");
    
    if (resultado.rows.length > 0) {
      return resultado.rows[0].id;
    }
    
    // Si no hay vendedores, creamos uno por defecto
    resultado = await pool.query(
      "INSERT INTO usuarios (nombre, email, password, rol) VALUES ($1, $2, $3, 'vendedor') RETURNING id",
      ["Vendedor Default", "vendedor@example.com", "hashedpassword"]
    );
    
    return resultado.rows[0].id;
  } catch (error) {
    console.error("❌ Error obteniendo/creando vendedor:", error);
    process.exit(1);
  }
};

// Función para migrar productos
const migrarProductos = async () => {
  try {
    const usuario_id = await obtenerVendedor();
    
    for (const producto of productos) {
      await pool.query(
        "INSERT INTO productos (titulo, descripcion, precio, imagen, categoria, stock, usuario_id) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *",
        [
          producto.title,
          producto.description,
          Math.floor(producto.price),
          producto.image,
          producto.category,
          10, // Stock por defecto
          usuario_id,  // Asignar al vendedor existente o recién creado
        ]
      );
      console.log(`Producto agregado: ${producto.title}`);
    }
    console.log("✅ Migración completada");
  } catch (error) {
    console.error("❌ Error en la migración:", error);
  } finally {
    pool.end(); // Cerrar conexión a la BD
  }
};

migrarProductos();
