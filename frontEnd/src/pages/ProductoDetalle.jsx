import React, { useContext } from "react";
import { useParams } from "react-router-dom";
import { ProductContext } from "../context/ProductContext";
import { CartContext } from "../context/CartContext";
import { Container, Row, Col, Button, Card } from "react-bootstrap";

const ProductoDetalle = () => {
  const { id } = useParams();
  const { products } = useContext(ProductContext);
  const { addToCart } = useContext(CartContext);

  
  const product = products.find((p) => p.id === parseInt(id));

  if (!product) {
    return <Container className="mt-5 text-center"><h2>Producto no encontrado</h2></Container>;
  }

  return (
    <Container className="mt-5">
      <Row>
        <Col md={6} className="text-center">
          <Card className="shadow-lg p-3">
            <Card.Img variant="top" src={product.image} style={{ maxHeight: "400px", objectFit: "contain" }} />
          </Card>
        </Col>
        <Col md={6}>
          <h2>{product.title}</h2>
          <p>{product.description}</p>
          <h4 className="text-success fw-bold">${product.price.toLocaleString()}</h4>
          <Button variant="primary" className="mt-3" onClick={() => addToCart(product)}>
            Añadir al Carrito
          </Button>
        </Col>
      </Row>
    </Container>
  );
};

export default ProductoDetalle;
