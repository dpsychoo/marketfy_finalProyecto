const pool = require("../config/database");

const createTables = async () => {
  try {
    await pool.query(`

CREATE TABLE public.compras (
    id integer NOT NULL,
    usuario_id integer,
    total integer NOT NULL,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    estado character varying(20) DEFAULT 'Pendiente'::character varying,
    metodo_pago_id integer,
    direccion_envio text,
    CONSTRAINT compras_estado_check CHECK (((estado)::text = ANY ((ARRAY['Pendiente'::character varying, 'Pagado'::character varying, 'Enviado'::character varying, 'Cancelado'::character varying])::text[])))
);
CREATE TABLE public.detalles_compra (
    id integer NOT NULL,
    compra_id integer,
    producto_id integer,
    cantidad integer NOT NULL,
    precio_unitario integer NOT NULL
);
CREATE TABLE public.favoritos (
    id integer NOT NULL,
    usuario_id integer,
    producto_id integer
);
CREATE TABLE public.metodos_pago (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL
);
CREATE TABLE public.productos (
    id integer NOT NULL,
    titulo character varying(255) NOT NULL,
    descripcion text NOT NULL,
    precio integer NOT NULL,
    imagen character varying(255) NOT NULL,
    categoria character varying(50) NOT NULL,
    stock integer DEFAULT 10 NOT NULL,
    usuario_id integer
);
CREATE TABLE public."reseñas_productos" (
    id integer NOT NULL,
    usuario_id integer,
    producto_id integer,
    calificacion integer,
    comentario text,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "reseñas_productos_calificacion_check" CHECK (((calificacion >= 1) AND (calificacion <= 5)))
);
CREATE TABLE public."reseñas_vendedores" (
    id integer NOT NULL,
    comprador_id integer,
    vendedor_id integer,
    calificacion integer,
    comentario text,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "reseñas_vendedores_calificacion_check" CHECK (((calificacion >= 1) AND (calificacion <= 5)))
);
CREATE TABLE public.roles_permisos (
    id integer NOT NULL,
    rol character varying(20) NOT NULL,
    puede_ver boolean DEFAULT true,
    puede_modificar boolean DEFAULT false,
    puede_eliminar boolean DEFAULT false,
    CONSTRAINT roles_permisos_rol_check CHECK (((rol)::text = ANY ((ARRAY['cliente'::character varying, 'vendedor'::character varying, 'admin'::character varying])::text[])))
);
CREATE TABLE public.usuarios (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    rol character varying(20) DEFAULT 'cliente'::character varying,
    CONSTRAINT usuarios_rol_check CHECK (((rol)::text = ANY ((ARRAY['cliente'::character varying, 'vendedor'::character varying, 'admin'::character varying])::text[])))
);

    `);
    console.log("🚀 Base de datos migrada con éxito.");
    process.exit();
  } catch (error) {
    console.error("❌ Error en la migración:", error);
    process.exit(1);
  }
};

createTables();