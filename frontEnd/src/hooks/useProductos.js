import { useEffect, useState } from "react";
import axios from "axios";

const API_URL = "http://localhost:3001/productos"; // despues cambiar esto en producción

const useProductos = () => {
  const [productos, setProductos] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchProductos = async () => {
      try {
        const response = await axios.get(API_URL);
        setProductos(response.data);
      } catch (err) {
        setError("Error al obtener productos");
      } finally {
        setLoading(false);
      }
    };
    fetchProductos();
  }, []);

  return { productos, loading, error };
};

export default useProductos;
