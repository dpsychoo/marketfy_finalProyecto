import React, { createContext, useState, useEffect } from "react";
import { toast } from "react-toastify";

export const AuthContext = createContext();

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    try {
      const savedUser = localStorage.getItem("user");
      if (savedUser) {
        const parsedUser = JSON.parse(savedUser);
        if (parsedUser && parsedUser.email) {
          setUser(parsedUser);
        } else {
          console.warn("Datos de usuario inválidos en localStorage.");
          localStorage.removeItem("user");
        }
      }
    } catch (error) {
      console.error("Error al cargar el usuario:", error);
      localStorage.removeItem("user");
    } finally {
      setLoading(false);
    }
  }, []);

  const login = (userData) => {
    if (userData && userData.email) {
      setUser(userData);
      localStorage.setItem("user", JSON.stringify(userData));
      toast.success(`Bienvenido, ${userData.name}`);
    } else {
      console.error("Error: los datos de usuario son inválidos.");
    }
  };

  const logout = () => {
    toast.info("Has cerrado sesión");
    setUser(null);
    localStorage.removeItem("user");
  };

  return (
    <AuthContext.Provider value={{ user, login, logout, loading }}>
      {children}
    </AuthContext.Provider>
  );
};
