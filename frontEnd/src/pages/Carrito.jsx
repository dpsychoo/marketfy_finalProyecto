import React, { useContext, useState } from "react";
import { CartContext } from "../context/CartContext";
import { Container, Row, Col, Button, Table, Form, Modal, Alert, Card } from "react-bootstrap";
import ProductCard from "../components/ProductCard";

const Carrito = () => {
  const { cart, removeFromCart, clearCart, addToCart } = useContext(CartContext);
  const [showModal, setShowModal] = useState(false);
  const [paymentMethod, setPaymentMethod] = useState("");
  const [paymentStatus, setPaymentStatus] = useState("");

  const total = cart.reduce((acc, item) => acc + item.price * item.quantity, 0);

  const handlePayment = () => {
    if (!paymentMethod) return;

    if (paymentMethod === "Tarjeta") {
      setPaymentStatus("Procesando pago...");
      setTimeout(() => {
        setPaymentStatus("Redirigiendo al portal de pagos...");
        setTimeout(() => {
          setPaymentStatus("✅ Pago exitoso. ¡Gracias por tu compra!");
          clearCart();
        }, 3000);
      }, 2000);
    } else if (paymentMethod === "Transferencia") {
      setPaymentStatus(
        "💳 Transferencia Bancaria\n\nBanco: Banco SCOTIABANK\nCuenta: 123456789\nTitular: MARKETFY LTDA\nRUT: 99.999.999-9\nCorreo: pagos@marketfy.com"
      );
    } else if (paymentMethod === "Bitcoin") {
      setPaymentStatus("🔗 Dirección Bitcoin: 1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa");
    }
  };

  return (
    <Container className="mt-5 text-center">
      <h2>Carrito de Compras</h2>
      {cart.length === 0 ? (
        <p>Tu carrito está vacío.</p>
      ) : (
        <>
          <Table striped bordered hover className="mt-4">
            <thead>
              <tr>
                <th>Producto</th>
                <th>Cantidad</th>
                <th>Precio</th>
                <th>Total</th>
                <th>Acciones</th>
              </tr>
            </thead>
            <tbody>
              {cart.map((item) => (
                <tr key={item.id}>
                  <td>
                    <ProductCard product={item} onAddToCart={null} />
                  </td>
                  <td>
                    <Form.Control
                      type="number"
                      min="1"
                      value={item.quantity}
                      onChange={(e) => {
                        const newQuantity = parseInt(e.target.value);
                        if (newQuantity > 0) {
                          addToCart({ ...item, quantity: newQuantity - item.quantity });
                        }
                      }}
                    />
                  </td>
                  <td>${item.price.toLocaleString()}</td>
                  <td>${(item.price * item.quantity).toLocaleString()}</td>
                  <td>
                    <Button variant="danger" onClick={() => removeFromCart(item.id)}>
                      Eliminar
                    </Button>
                  </td>
                </tr>
              ))}
            </tbody>
          </Table>

          {}
          <Card className="mt-4 mx-auto text-center shadow-lg" style={{ maxWidth: "400px", borderRadius: "10px" }}>
            <Card.Body>
              <h4 className="fw-bold">Total a pagar</h4>
              <h2 className="text-success fw-bold">${total.toLocaleString()}</h2>
            </Card.Body>
          </Card>

          <div className="mt-3">
            <Button variant="secondary" className="me-2" onClick={clearCart}>
              Vaciar Carrito
            </Button>
            <Button variant="success" onClick={() => setShowModal(true)}>
              Ir a Pagar
            </Button>
          </div>
        </>
      )}

      {}
      <Modal show={showModal} onHide={() => setShowModal(false)} centered>
        <Modal.Header closeButton>
          <Modal.Title>Selecciona un Método de Pago</Modal.Title>
        </Modal.Header>
        <Modal.Body>
          <Form>
            <Form.Group>
              <Form.Label>Método de Pago:</Form.Label>
              <Form.Control
                as="select"
                value={paymentMethod}
                onChange={(e) => setPaymentMethod(e.target.value)}
              >
                <option value="">Selecciona un método...</option>
                <option value="Tarjeta">Tarjeta de Crédito/Débito</option>
                <option value="Transferencia">Transferencia Bancaria</option>
                <option value="Bitcoin">Bitcoin</option>
              </Form.Control>
            </Form.Group>
          </Form>
          {paymentStatus && (
            <Alert className="mt-3" variant={paymentMethod === "Tarjeta" ? "info" : "success"}>
              {paymentStatus}
            </Alert>
          )}
        </Modal.Body>
        <Modal.Footer>
          <Button variant="secondary" onClick={() => setShowModal(false)}>
            Cancelar
          </Button>
          <Button variant="success" onClick={handlePayment} disabled={!paymentMethod}>
            Confirmar Pago
          </Button>
        </Modal.Footer>
      </Modal>
    </Container>
  );
};

export default Carrito;
