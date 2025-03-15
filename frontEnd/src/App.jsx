import React from 'react';
import { Outlet } from 'react-router-dom';
import './App.css';

const App = () => (
  <div className="app-container">
    {}
    <div className="app-content">
      <Outlet /> {}
    </div>
  </div>
);

export default App;
