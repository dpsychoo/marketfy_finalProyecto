import React from "react";
import ReactDOM from "react-dom/client";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import { AuthProvider } from "./context/AuthContext";
import { CartProvider } from "./context/CartContext";
import { ProductProvider } from "./context/ProductContext";
import App from "./App";
import Home from "./pages/Home";
import Ofertas from "./pages/Ofertas";
import Registrarse from "./pages/Registrarse";
import Login from "./pages/Login";
import Carrito from "./pages/Carrito";
import Perfil from "./pages/Perfil";
import Producto from "./pages/Producto";
import Navbar from "./components/Navbar";
import "bootstrap/dist/css/bootstrap.min.css";
import "./index.css";
import { ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css"; 

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <AuthProvider>
      <CartProvider>
        <ProductProvider>
          <Router>
            <Navbar />
            <ToastContainer position="top-right" autoClose={3000} /> {}
            <Routes>
              <Route path="/" element={<App />}>
                <Route index element={<Home />} />
                <Route path="ofertas" element={<Ofertas />} />
                <Route path="registrarse" element={<Registrarse />} />
                <Route path="login" element={<Login />} />
                <Route path="carrito" element={<Carrito />} />
                <Route path="perfil" element={<Perfil />} />
                <Route path="producto/:id" element={<Producto />} />
              </Route>
            </Routes>
          </Router>
        </ProductProvider>
      </CartProvider>
    </AuthProvider>
  </React.StrictMode>
);
