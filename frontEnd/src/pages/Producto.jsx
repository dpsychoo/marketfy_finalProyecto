import React, { useContext } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { ProductContext } from "../context/ProductContext";
import { CartContext } from "../context/CartContext";
import { Container, Row, Col, Button, Image, Card } from "react-bootstrap";

const Producto = () => {
  const { id } = useParams();
  const navigate = useNavigate();
  const { products, loading } = useContext(ProductContext);
  const { addToCart } = useContext(CartContext);

  if (loading) {
    return <p className="text-center mt-5">Cargando producto...</p>;
  }

  const product = products.find((p) => p.id === parseInt(id));

  if (!product) {
    return <p className="text-center mt-5">Producto no encontrado.</p>;
  }

  return (
    <Container className="mt-5">
      <Row className="justify-content-center">
        <Col md={8}>
          <Card className="shadow-lg border-0 rounded p-4">
            <Row>
              <Col md={6} className="text-center">
                <Image src={product.imagen} alt={product.titulo} fluid className="rounded" style={{ maxHeight: "400px" }} />
              </Col>
              <Col md={6} className="d-flex flex-column justify-content-center">
                <h2 className="mb-3">{product.titulo}</h2>
                <h4 className="text-primary mb-3">${product.precio.toLocaleString()}</h4>
                <p className="text-muted">{product.descripcion}</p>
                <Button variant="success" className="w-100 mb-2" onClick={() => addToCart(product)}>
                  🛒 Añadir al Carrito
                </Button>
                <Button variant="secondary" className="w-100" onClick={() => navigate(-1)}>
                  🔙 Volver
                </Button>
              </Col>
            </Row>
          </Card>
        </Col>
      </Row>
    </Container>
  );
};

export default Producto;
