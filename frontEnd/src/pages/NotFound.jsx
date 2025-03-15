import React from "react";
import { Container, Button } from "react-bootstrap";
import { useNavigate } from "react-router-dom";

const NotFound = () => {
  const navigate = useNavigate();

  return (
    <Container className="mt-5 text-center">
      <h1>404</h1>
      <h3>Página no encontrada</h3>
      <p>Lo sentimos, la página que buscas no existe.</p>
      <Button variant="primary" onClick={() => navigate("/")}>Volver al Inicio</Button>
    </Container>
  );
};

export default NotFound;
