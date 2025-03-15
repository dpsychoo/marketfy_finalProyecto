import React, { createContext, useState, useEffect } from "react";
import axios from "axios";

const API_URL = "http://localhost:5000/api/productos/"; // URL correcta del backend

export const ProductContext = createContext();

export const ProductProvider = ({ children }) => {
  const [products, setProducts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [categories, setCategories] = useState([]);

  useEffect(() => {
    const fetchProducts = async () => {
      try {
        console.log("Cargando productos desde:", API_URL);
        const response = await axios.get(API_URL);
        console.log("Respuesta de la API:", response.data);
        setProducts(response.data);
        console.log("Productos guardados en el estado:", response.data);

        // Extraer categorías únicas de los productos obtenidos de la API
        const uniqueCategories = [...new Set(response.data.map((product) => product.categoria))];
        setCategories(uniqueCategories);
      } catch (error) {
        console.error("Error al obtener productos:", error);
      } finally {
        setLoading(false);
      }
    };

    fetchProducts();
  }, []);

  return (
    <ProductContext.Provider value={{ products, loading, categories }}>
      {children}
    </ProductContext.Provider>
  );
};