import React, { useContext, useEffect, useState } from "react";
import { AuthContext } from "../context/AuthContext";
import { Container, Button, Alert } from "react-bootstrap";
import { useNavigate } from "react-router-dom";

const Perfil = () => {
  const { user, logout } = useContext(AuthContext);
  const navigate = useNavigate();
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!user) {
      navigate("/login");
    } else {
      setLoading(false);
    }
  }, [user, navigate]);

  if (loading) {
    return <p className="text-center mt-5">Cargando perfil...</p>;
  }

  return (
    <Container className="mt-5 text-center">
      <h2>Perfil de {user?.name || "Usuario"}</h2>
      <p><strong>Email:</strong> {user?.email || "No disponible"}</p>

      <Button variant="danger" className="mt-3" onClick={() => { logout(); navigate("/"); }}>
        Cerrar Sesión
      </Button>

      {!user?.name && (
        <Alert variant="warning" className="mt-3">
          No tienes un nombre registrado. Intenta cerrar sesión e iniciar nuevamente.
        </Alert>
      )}
    </Container>
  );
};

export default Perfil;
