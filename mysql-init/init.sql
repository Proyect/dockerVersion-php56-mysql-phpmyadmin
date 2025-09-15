-- Script de inicialización de la base de datos
-- Este archivo se ejecuta automáticamente cuando se crea el contenedor MySQL

-- Crear la base de datos si no existe
CREATE DATABASE IF NOT EXISTS php_app CHARACTER SET utf8 COLLATE utf8_general_ci;

-- Usar la base de datos
USE php_app;

-- Crear tabla de ejemplo
CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insertar datos de ejemplo
INSERT INTO usuarios (nombre, email) VALUES 
('Juan Pérez', 'juan@ejemplo.com'),
('María García', 'maria@ejemplo.com'),
('Carlos López', 'carlos@ejemplo.com');

-- Crear tabla de productos de ejemplo
CREATE TABLE IF NOT EXISTS productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insertar productos de ejemplo
INSERT INTO productos (nombre, descripcion, precio, stock) VALUES 
('Laptop HP', 'Laptop HP Pavilion 15 pulgadas', 8500.00, 10),
('Mouse Logitech', 'Mouse inalámbrico Logitech', 250.00, 50),
('Teclado Mecánico', 'Teclado mecánico RGB', 1200.00, 25),
('Monitor Samsung', 'Monitor Samsung 24 pulgadas Full HD', 3200.00, 15);

-- Mostrar mensaje de confirmación
SELECT 'Base de datos inicializada correctamente' as mensaje;

