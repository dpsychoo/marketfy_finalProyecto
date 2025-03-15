--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
-- Dumped by pg_dump version 17.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: compras; Type: TABLE; Schema: public; Owner: postgres
--

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


ALTER TABLE public.compras OWNER TO postgres;

--
-- Name: compras_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.compras_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.compras_id_seq OWNER TO postgres;

--
-- Name: compras_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.compras_id_seq OWNED BY public.compras.id;


--
-- Name: detalles_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalles_compra (
    id integer NOT NULL,
    compra_id integer,
    producto_id integer,
    cantidad integer NOT NULL,
    precio_unitario integer NOT NULL
);


ALTER TABLE public.detalles_compra OWNER TO postgres;

--
-- Name: detalles_compra_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detalles_compra_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.detalles_compra_id_seq OWNER TO postgres;

--
-- Name: detalles_compra_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detalles_compra_id_seq OWNED BY public.detalles_compra.id;


--
-- Name: favoritos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favoritos (
    id integer NOT NULL,
    usuario_id integer,
    producto_id integer
);


ALTER TABLE public.favoritos OWNER TO postgres;

--
-- Name: favoritos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.favoritos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.favoritos_id_seq OWNER TO postgres;

--
-- Name: favoritos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.favoritos_id_seq OWNED BY public.favoritos.id;


--
-- Name: metodos_pago; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.metodos_pago (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public.metodos_pago OWNER TO postgres;

--
-- Name: metodos_pago_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.metodos_pago_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.metodos_pago_id_seq OWNER TO postgres;

--
-- Name: metodos_pago_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.metodos_pago_id_seq OWNED BY public.metodos_pago.id;


--
-- Name: productos; Type: TABLE; Schema: public; Owner: postgres
--

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


ALTER TABLE public.productos OWNER TO postgres;

--
-- Name: productos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.productos_id_seq OWNER TO postgres;

--
-- Name: productos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productos_id_seq OWNED BY public.productos.id;


--
-- Name: reseñas_productos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."reseñas_productos" (
    id integer NOT NULL,
    usuario_id integer,
    producto_id integer,
    calificacion integer,
    comentario text,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "reseñas_productos_calificacion_check" CHECK (((calificacion >= 1) AND (calificacion <= 5)))
);


ALTER TABLE public."reseñas_productos" OWNER TO postgres;

--
-- Name: reseñas_productos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."reseñas_productos_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."reseñas_productos_id_seq" OWNER TO postgres;

--
-- Name: reseñas_productos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."reseñas_productos_id_seq" OWNED BY public."reseñas_productos".id;


--
-- Name: reseñas_vendedores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."reseñas_vendedores" (
    id integer NOT NULL,
    comprador_id integer,
    vendedor_id integer,
    calificacion integer,
    comentario text,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "reseñas_vendedores_calificacion_check" CHECK (((calificacion >= 1) AND (calificacion <= 5)))
);


ALTER TABLE public."reseñas_vendedores" OWNER TO postgres;

--
-- Name: reseñas_vendedores_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."reseñas_vendedores_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."reseñas_vendedores_id_seq" OWNER TO postgres;

--
-- Name: reseñas_vendedores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."reseñas_vendedores_id_seq" OWNED BY public."reseñas_vendedores".id;


--
-- Name: roles_permisos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles_permisos (
    id integer NOT NULL,
    rol character varying(20) NOT NULL,
    puede_ver boolean DEFAULT true,
    puede_modificar boolean DEFAULT false,
    puede_eliminar boolean DEFAULT false,
    CONSTRAINT roles_permisos_rol_check CHECK (((rol)::text = ANY ((ARRAY['cliente'::character varying, 'vendedor'::character varying, 'admin'::character varying])::text[])))
);


ALTER TABLE public.roles_permisos OWNER TO postgres;

--
-- Name: roles_permisos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_permisos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_permisos_id_seq OWNER TO postgres;

--
-- Name: roles_permisos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_permisos_id_seq OWNED BY public.roles_permisos.id;


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    rol character varying(20) DEFAULT 'cliente'::character varying,
    CONSTRAINT usuarios_rol_check CHECK (((rol)::text = ANY ((ARRAY['cliente'::character varying, 'vendedor'::character varying, 'admin'::character varying])::text[])))
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_seq OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- Name: ventas_vendedores; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.ventas_vendedores AS
 SELECT p.usuario_id AS vendedor_id,
    c.id AS compra_id,
    c.fecha,
    c.estado,
    sum((dc.cantidad * dc.precio_unitario)) AS total_venta
   FROM ((public.compras c
     JOIN public.detalles_compra dc ON ((c.id = dc.compra_id)))
     JOIN public.productos p ON ((dc.producto_id = p.id)))
  GROUP BY p.usuario_id, c.id, c.fecha, c.estado;


ALTER VIEW public.ventas_vendedores OWNER TO postgres;

--
-- Name: compras id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compras ALTER COLUMN id SET DEFAULT nextval('public.compras_id_seq'::regclass);


--
-- Name: detalles_compra id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalles_compra ALTER COLUMN id SET DEFAULT nextval('public.detalles_compra_id_seq'::regclass);


--
-- Name: favoritos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favoritos ALTER COLUMN id SET DEFAULT nextval('public.favoritos_id_seq'::regclass);


--
-- Name: metodos_pago id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metodos_pago ALTER COLUMN id SET DEFAULT nextval('public.metodos_pago_id_seq'::regclass);


--
-- Name: productos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos ALTER COLUMN id SET DEFAULT nextval('public.productos_id_seq'::regclass);


--
-- Name: reseñas_productos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."reseñas_productos" ALTER COLUMN id SET DEFAULT nextval('public."reseñas_productos_id_seq"'::regclass);


--
-- Name: reseñas_vendedores id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."reseñas_vendedores" ALTER COLUMN id SET DEFAULT nextval('public."reseñas_vendedores_id_seq"'::regclass);


--
-- Name: roles_permisos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_permisos ALTER COLUMN id SET DEFAULT nextval('public.roles_permisos_id_seq'::regclass);


--
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- Data for Name: compras; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.compras (id, usuario_id, total, fecha, estado, metodo_pago_id, direccion_envio) FROM stdin;
7	1	2019970	2025-03-11 02:33:27.953148	Pagado	1	Calle Falsa 123, Springfield
8	1	2019970	2025-03-11 02:52:34.830156	Pendiente	1	Calle Falsa 123, Springfield
\.


--
-- Data for Name: detalles_compra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalles_compra (id, compra_id, producto_id, cantidad, precio_unitario) FROM stdin;
\.


--
-- Data for Name: favoritos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.favoritos (id, usuario_id, producto_id) FROM stdin;
\.


--
-- Data for Name: metodos_pago; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.metodos_pago (id, nombre) FROM stdin;
1	Tarjeta de Crédito/Débito
2	Transferencia Bancaria
3	Bitcoin
\.


--
-- Data for Name: productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productos (id, titulo, descripcion, precio, imagen, categoria, stock, usuario_id) FROM stdin;
14	Notebook IdeaPad Slim 3 Gen 8	Rendimiento potente con procesador Core i5, pantalla FHD de 15.6” y almacenamiento SSD ultrarrápido.	469990	https://catalogo.movistar.cl/media/catalog/product/cache/59f9333d8451bc946b99b13dadf94dd3/t/a/tagcllei38i5gr_370_other_1_1.webp	Laptops	10	2
15	Galaxy Buds3 Gray	Auriculares inalámbricos con sonido envolvente y cancelación de ruido activa.	109990	https://catalogo.movistar.cl/media/catalog/product/cache/59f9333d8451bc946b99b13dadf94dd3/t/a/tagclsabuds3gr_370_other_7_gr3ap6vglgcvbhxo.webp	Audífonos	10	2
16	PS5 Digital Slim + Returnal y Ratchet & Clank	Nueva PlayStation 5 Digital Slim con dos juegos incluidos para máxima diversión.	599990	https://catalogo.movistar.cl/media/catalog/product/cache/59f9333d8451bc946b99b13dadf94dd3/t/a/tagclsnc5sdj00_370_other_1_iuprdbigetjccwis.webp	Consolas	10	2
17	iPad Pro 13" Wi-Fi 512GB Negro	Potente iPad Pro con chip M2, pantalla de 13 pulgadas y 512GB de almacenamiento.	1799990	https://catalogo.movistar.cl/media/catalog/product/cache/59f9333d8451bc946b99b13dadf94dd3/t/a/tagclapp3w4ene_370_other_2_mxy1ibt1cuh6ubcq.webp	Tablets	10	2
18	Watch Series 10 (GPS) Negro Azabache 46mm	Apple Watch Series 10 con pantalla más grande y mejores funciones de salud.	504990	https://catalogo.movistar.cl/media/catalog/product/cache/59f9333d8451bc946b99b13dadf94dd3/t/a/tagclaps10glne_370_other_2_1_vtcus2qwbngrlao9.webp	Smartwatches	10	2
19	Switch Oled + Super Mario Bros Wonder	Nintendo Switch OLED con el nuevo juego Super Mario Bros Wonder incluido.	409990	https://catalogo.movistar.cl/media/catalog/product/cache/59f9333d8451bc946b99b13dadf94dd3/t/a/tagclniswomw00_370_other_1.webp	Consolas	10	2
20	Galaxy Watch7 BT 44mm Verde	Nuevo Galaxy Watch7 con pantalla más grande y más funciones de salud.	299990	https://catalogo.movistar.cl/media/catalog/product/cache/59f9333d8451bc946b99b13dadf94dd3/t/a/tagclsawa7btve_370_other_1_cfca1ckjssx3yh8f.webp	Smartwatches	10	2
21	Tablet Galaxy S6 Lite 10.4" Wi-Fi 64GB + lápiz + funda	Tablet Samsung Galaxy S6 Lite con lápiz y funda incluidos, ideal para trabajar y estudiar.	226990	https://catalogo.movistar.cl/media/catalog/product/cache/59f9333d8451bc946b99b13dadf94dd3/t/a/tagclsats6lwgr_370_other_1.webp	Tablets	10	2
\.


--
-- Data for Name: reseñas_productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."reseñas_productos" (id, usuario_id, producto_id, calificacion, comentario, fecha) FROM stdin;
\.


--
-- Data for Name: reseñas_vendedores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."reseñas_vendedores" (id, comprador_id, vendedor_id, calificacion, comentario, fecha) FROM stdin;
\.


--
-- Data for Name: roles_permisos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles_permisos (id, rol, puede_ver, puede_modificar, puede_eliminar) FROM stdin;
1	cliente	t	f	f
2	vendedor	t	t	f
3	admin	t	t	t
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, nombre, email, password, rol) FROM stdin;
1	Eminem	eminem@slimshady.com	$2b$10$7rGEP3dyEmsAE25ofrW/wu.JsUTzozCU3bGCnaAjgUOaKFqkm0Z3W	cliente
2	Jordan Belfort	vendedor@marketfy.com	$2b$10$lnrAwHh8C/prXpicq6RnuuFwIcVNcvfoOpy1PcWMPPSTw1IoWAWmO	vendedor
4	Cristiano Ronaldo	cr7@marketfy.com	$2b$10$I5gTGJAe7LP63A/cQJkHYOZ0EVO7iUY.uA5hA0FKg99K2zqHxOVb2	cliente
5	Jeff Bezos	jeff@vendedorMF.com	$2b$10$rpXoLy2Wubai/6uh9WfCg.LX8NbZ7p2m83m18yZQbHZ5j4wwnTQni	vendedor
6	Elon Musk	elon@adminMF.com	$2b$10$YYOUu/mmRmcpc3H.2dU62OdvRNUY0vVOMzGUKl2MhO.HIGUW1N1j6	admin
7	Test User	test1741676051690@marketfy.com	$2b$10$FGR6vWNPlLbIZw/Rj2nN6OVttrwmOs0y5ek81RMUfOakmrfOswiAq	cliente
3	Lionel Messi	messi@marketfy.com	$2b$10$kQLRSCJkJZRuvCVEgNiEreendvRuDdR63.gyV4fRmLYRdzLWlCmbS	cliente
8	Test User	test1741768562338@marketfy.com	$2b$10$7RPqWnGRwEFgRSzQ/L9/ze/ZNRQB6isoCA0g4EbwufkR5HOm8Pg7O	cliente
9	Test User	test1741768750587@marketfy.com	$2b$10$mOVMb7XnCBva0jUI7d2Ff.kxsN09u7Ohw8T3TAcJL1002rC5z.j7q	cliente
10	Test User	test1741769538414@marketfy.com	$2b$10$7smti8Q0IqLjnAePKsq9Cu1NjTaPi4IBH0pdG0Dmwfzz6Ugtn35ta	cliente
11	Test User	test1741769555422@marketfy.com	$2b$10$GCqIezia1X.q5IRtRlHIFOl3DhCsMT40pHBmecUjO0sEXWWTkBUbO	cliente
12	Test User	test1741769583745@marketfy.com	$2b$10$XDAGrlc2xKBElkehu8aWMO0sodHcq3qme.V.EoInI9rzN2svx6CwO	cliente
13	Test User	test1741771201845@marketfy.com	$2b$10$ud6Ya7slYzWF6TTi8EQI7uw6fUCZrqFqMkWa7ZKMku9OufH0gs8te	cliente
14	Test User	test1741774314647@marketfy.com	$2b$10$cUEBeqvpSx/dGdmqmhf.fOXlmAgs/hEe1e3J3G7sR/NW4dhUbJ97W	cliente
15	guest123	123@123	$2b$10$ziR4pMtVs1IGDiVqx/4xgOT.gNxY.OViGmhvNcmD9ivnAnhERv55q	cliente
\.


--
-- Name: compras_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.compras_id_seq', 10, true);


--
-- Name: detalles_compra_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detalles_compra_id_seq', 8, true);


--
-- Name: favoritos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.favoritos_id_seq', 1, false);


--
-- Name: metodos_pago_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.metodos_pago_id_seq', 3, true);


--
-- Name: productos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productos_id_seq', 21, true);


--
-- Name: reseñas_productos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."reseñas_productos_id_seq"', 1, false);


--
-- Name: reseñas_vendedores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."reseñas_vendedores_id_seq"', 1, false);


--
-- Name: roles_permisos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_permisos_id_seq', 3, true);


--
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 15, true);


--
-- Name: compras compras_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compras
    ADD CONSTRAINT compras_pkey PRIMARY KEY (id);


--
-- Name: detalles_compra detalles_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalles_compra
    ADD CONSTRAINT detalles_compra_pkey PRIMARY KEY (id);


--
-- Name: favoritos favoritos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favoritos
    ADD CONSTRAINT favoritos_pkey PRIMARY KEY (id);


--
-- Name: favoritos favoritos_usuario_id_producto_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favoritos
    ADD CONSTRAINT favoritos_usuario_id_producto_id_key UNIQUE (usuario_id, producto_id);


--
-- Name: metodos_pago metodos_pago_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metodos_pago
    ADD CONSTRAINT metodos_pago_pkey PRIMARY KEY (id);


--
-- Name: productos productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id);


--
-- Name: reseñas_productos reseñas_productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."reseñas_productos"
    ADD CONSTRAINT "reseñas_productos_pkey" PRIMARY KEY (id);


--
-- Name: reseñas_vendedores reseñas_vendedores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."reseñas_vendedores"
    ADD CONSTRAINT "reseñas_vendedores_pkey" PRIMARY KEY (id);


--
-- Name: roles_permisos roles_permisos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_permisos
    ADD CONSTRAINT roles_permisos_pkey PRIMARY KEY (id);


--
-- Name: roles_permisos roles_permisos_rol_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_permisos
    ADD CONSTRAINT roles_permisos_rol_key UNIQUE (rol);


--
-- Name: usuarios usuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- Name: compras compras_metodo_pago_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compras
    ADD CONSTRAINT compras_metodo_pago_id_fkey FOREIGN KEY (metodo_pago_id) REFERENCES public.metodos_pago(id);


--
-- Name: compras compras_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compras
    ADD CONSTRAINT compras_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: detalles_compra detalles_compra_compra_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalles_compra
    ADD CONSTRAINT detalles_compra_compra_id_fkey FOREIGN KEY (compra_id) REFERENCES public.compras(id) ON DELETE CASCADE;


--
-- Name: detalles_compra detalles_compra_producto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalles_compra
    ADD CONSTRAINT detalles_compra_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES public.productos(id) ON DELETE CASCADE;


--
-- Name: favoritos favoritos_producto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favoritos
    ADD CONSTRAINT favoritos_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES public.productos(id) ON DELETE CASCADE;


--
-- Name: favoritos favoritos_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favoritos
    ADD CONSTRAINT favoritos_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: usuarios fk_rol; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT fk_rol FOREIGN KEY (rol) REFERENCES public.roles_permisos(rol) ON DELETE SET NULL;


--
-- Name: productos productos_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: reseñas_productos reseñas_productos_producto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."reseñas_productos"
    ADD CONSTRAINT "reseñas_productos_producto_id_fkey" FOREIGN KEY (producto_id) REFERENCES public.productos(id) ON DELETE CASCADE;


--
-- Name: reseñas_productos reseñas_productos_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."reseñas_productos"
    ADD CONSTRAINT "reseñas_productos_usuario_id_fkey" FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: reseñas_vendedores reseñas_vendedores_comprador_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."reseñas_vendedores"
    ADD CONSTRAINT "reseñas_vendedores_comprador_id_fkey" FOREIGN KEY (comprador_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: reseñas_vendedores reseñas_vendedores_vendedor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."reseñas_vendedores"
    ADD CONSTRAINT "reseñas_vendedores_vendedor_id_fkey" FOREIGN KEY (vendedor_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

