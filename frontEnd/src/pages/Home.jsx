import React, { useContext, useState } from "react";
import { Container, Row, Col, Button, Carousel, Nav } from "react-bootstrap";
import { useNavigate } from "react-router-dom";
import { ProductContext } from "../context/ProductContext";
import { CartContext } from "../context/CartContext";

const Home = () => {
  const navigate = useNavigate();
  const { products } = useContext(ProductContext);
  const { addToCart } = useContext(CartContext);
  const [activeIndex, setActiveIndex] = useState(0);

  const categories = [
    { name: "Más Productos", path: "Todos" },
    { name: "Audífonos", path: "Audífonos" },
    { name: "Consolas", path: "Consolas" },
    { name: "Smartwatch", path: "Smartwatch" },
    { name: "Tablets", path: "Tablets" }
  ];

  return (
    <Container fluid className="app-container">
      {}
      <Row className="home-content">
        <Col md={6} className="carousel-section d-flex justify-content-center align-items-center">
          <Carousel
            className="carousel-container"
            activeIndex={activeIndex}
            onSelect={(selectedIndex) => setActiveIndex(selectedIndex)}
          >
            {products.map((product, index) => (
              <Carousel.Item key={index}>
                <div className="carousel-image-container">
                  <img className="carousel-image" src={product.imagen ? product.imagen : "https://via.placeholder.com/150"} alt={product.titulo || "Producto"} />
                </div>
              </Carousel.Item>
            ))}
          </Carousel>
        </Col>

        <Col md={6} className="info-section d-flex justify-content-center align-items-center">
          <div className="product-info-container">
            <h1 className="product-title">{products[activeIndex]?.titulo || "Producto"}</h1>
            <p className="product-description">{products[activeIndex]?.descripcion || "Descripción no disponible"}</p>
            <h2 className="product-price">
              ${products[activeIndex]?.precio ? products[activeIndex].precio.toLocaleString() : "0"}
            </h2>
            <Button variant="primary" className="product-button" onClick={() => navigate('/ofertas')}>
              Ver Más
            </Button>
          </div>
        </Col>
      </Row>

      {}
      <Container fluid className="category-section mt-4">
        <Row>
          <Col>
            <Nav className="category-nav d-flex justify-content-center">
              {categories.map((category, index) => (
                <Nav.Item key={index}>
                  <Nav.Link className="category-item" onClick={() => navigate(`/ofertas?categoria=${category.path}`)}>
                    {category.name}
                  </Nav.Link>
                </Nav.Item>
              ))}
            </Nav>
          </Col>
        </Row>
      </Container>

      {}
      <Container fluid className="hot-sale-section mt-5">
        <Row>
          <Col>
            <h2 className="hot-sale-title text-center">PRODUCTOS HOT SALE</h2>
            <div className="hot-sale-container d-flex justify-content-center">
              {products.slice(0, 3).map((product, index) => (
                <div key={index} className="hot-sale-card text-center">
                  <img className="hot-sale-image" src={product.imagen ? product.imagen : "https://via.placeholder.com/150"} alt={product.titulo || "Producto"} />
                  <h3 className="hot-sale-product-title">{product.titulo || "Producto"}</h3>
                  <p className="hot-sale-price">
                    ${product.precio ? product.precio.toLocaleString() : "0"}
                  </p>
                  <div className="d-flex justify-content-around">
                    <Button variant="primary" onClick={() => addToCart(product)}>Añadir al Carrito</Button>
                    <Button variant="secondary" onClick={() => navigate(`/producto/${product.id}`)}>Ver Detalle</Button>
                  </div>
                </div>
              ))}
            </div>
          </Col>
        </Row>
      </Container>

      {}
      <footer className="footer mt-auto">
        <Container>
          <Row>
            <Col className="text-center py-3">
              <p>MARKETFY</p>
            </Col>
          </Row>
        </Container>
      </footer>
    </Container>
  );
};

export default Home;