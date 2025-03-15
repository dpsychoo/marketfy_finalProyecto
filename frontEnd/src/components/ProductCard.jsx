import React from "react";
import { Card, Button } from "react-bootstrap";
import { useNavigate } from "react-router-dom";
import { toast } from "react-toastify";

const ProductCard = ({ product, onAddToCart }) => {
  const navigate = useNavigate();

  return (
    <Card className="mb-4 shadow-sm">
      <Card.Img 
        variant="top" 
        src={product.imagen ? product.imagen : "https://raw.githubusercontent.com/zalog/placeholder-loading/154053b7fead8e8a55b3f6f7fa6d48c1575b1142/docs/imgs/placeholder-loading-demo-1.gif"} 
        alt={product.titulo || "Producto sin nombre"}
        style={{ height: "200px", objectFit: "contain" }} 
      />
      <Card.Body>
        <Card.Title>{product.titulo || "Producto sin nombre"}</Card.Title>
        <Card.Text>{product.descripcion || "Sin descripción disponible"}</Card.Text>
        <h4 className="text-primary">${product.precio ? product.precio.toLocaleString() : "0"}</h4>
        <div className="d-flex justify-content-between">
          <Button 
            variant="primary" 
            onClick={() => {
              onAddToCart(product);
              toast.success(`Añadido al carrito: ${product.titulo}`);
            }}
          >
            Añadir al Carrito
          </Button>
          <Button variant="secondary" onClick={() => navigate(`/producto/${product.id}`)}>
            Ver Detalle
          </Button>
        </div>
      </Card.Body>
    </Card>
  );
};

export default ProductCard;
