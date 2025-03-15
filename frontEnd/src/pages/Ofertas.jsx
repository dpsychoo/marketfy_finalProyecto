import React, { useContext, useState } from "react";
import { ProductContext } from "../context/ProductContext";
import { CartContext } from "../context/CartContext";
import { Container, Row, Col, Spinner, Form } from "react-bootstrap";
import ProductCard from "../components/ProductCard";
import { useLocation } from "react-router-dom";

const Ofertas = () => {
  const { products, loading, categories = [] } = useContext(ProductContext);
  const { addToCart } = useContext(CartContext);
  const location = useLocation();
  const params = new URLSearchParams(location.search);
  const [selectedCategory, setSelectedCategory] = useState(params.get("categoria") || "Todos");
  const [searchTerm, setSearchTerm] = useState("");

  const filteredProducts = products.filter((product) =>
    (selectedCategory === "Todos" || product.categoria === selectedCategory) &&
    product.titulo.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <Container className="mt-5 text-center">
      <h2>Nuestros Productos</h2>

      {}
      <Row className="mt-3 mb-4 justify-content-center">
        <Col md={4}>
          <Form.Group>
            <Form.Label>Filtrar por categoría:</Form.Label>
            <Form.Control
              as="select"
              value={selectedCategory}
              onChange={(e) => setSelectedCategory(e.target.value)}
            >
              <option value="Todos">Todos</option>
              {categories.length > 0 ? (
                categories.map((category, index) => (
                  <option key={index} value={category}>
                    {category}
                  </option>
                ))
              ) : (
                <option disabled>No hay categorías disponibles</option>
              )}
            </Form.Control>
          </Form.Group>
        </Col>

        <Col md={4}>
          <Form.Group>
            <Form.Label>Buscar producto:</Form.Label>
            <Form.Control
              type="text"
              placeholder="Ingrese el nombre del producto..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
            />
          </Form.Group>
        </Col>
      </Row>

      {loading ? (
        <Spinner animation="border" role="status" className="mt-3">
          <span className="visually-hidden">Cargando productos...</span>
        </Spinner>
      ) : (
        <Row className="justify-content-center mt-4">
          {filteredProducts.length === 0 ? (
            <p>No se encontraron productos.</p>
          ) : (
            filteredProducts.map((product) => (
              <Col key={product.id} md={4} className="mb-4">
                <ProductCard product={product} onAddToCart={addToCart} />
              </Col>
            ))
          )}
        </Row>
      )}
    </Container>
  );
};

export default Ofertas;
