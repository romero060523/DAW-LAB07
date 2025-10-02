-- =============================================
-- Scripts para MySQL Workbench
-- Proyecto CRUD Producto-Categoría
-- =============================================

-- Crear base de datos
CREATE DATABASE IF NOT EXISTS crud_productos;
USE crud_productos;

-- Crear tabla Categoría
CREATE TABLE IF NOT EXISTS categoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Crear tabla Producto
CREATE TABLE IF NOT EXISTS producto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    categoria_id INT NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (categoria_id) REFERENCES categoria(id) ON DELETE CASCADE
);

-- =============================================
-- DATOS DE PRUEBA
-- =============================================

-- Insertar categorías
INSERT INTO categoria (nombre, descripcion) VALUES
('Electrónicos', 'Dispositivos electrónicos y gadgets'),
('Ropa', 'Vestimenta para hombres, mujeres y niños'),
('Hogar', 'Artículos para el hogar y decoración'),
('Deportes', 'Equipos y accesorios deportivos'),
('Libros', 'Libros físicos y digitales');

-- Insertar productos
INSERT INTO producto (nombre, descripcion, precio, stock, categoria_id) VALUES
('iPhone 15', 'Smartphone Apple con cámara de 48MP', 999.99, 25, 1),
('Samsung Galaxy S24', 'Smartphone Android con IA integrada', 899.99, 30, 1),
('Laptop Dell XPS 13', 'Laptop ultrabook con procesador Intel i7', 1299.99, 15, 1),
('Camiseta Nike', 'Camiseta deportiva de algodón', 29.99, 100, 2),
('Jeans Levis 501', 'Pantalón vaquero clásico', 79.99, 50, 2),
('Zapatillas Adidas', 'Zapatillas deportivas para running', 89.99, 75, 2),
('Sofá 3 plazas', 'Sofá moderno en tela gris', 599.99, 10, 3),
('Mesa de centro', 'Mesa de centro en madera de roble', 199.99, 20, 3),
('Lámpara LED', 'Lámpara de escritorio con luz regulable', 49.99, 40, 3),
('Balón de fútbol', 'Balón oficial FIFA', 39.99, 60, 4),
('Raqueta de tenis', 'Raqueta profesional Wilson', 149.99, 25, 4),
('Bicicleta de montaña', 'Bicicleta todo terreno 21 velocidades', 399.99, 8, 4),
('El Quijote', 'Novela clásica de Miguel de Cervantes', 19.99, 200, 5),
('Clean Code', 'Libro de programación por Robert Martin', 45.99, 50, 5),
('1984', 'Novela distópica de George Orwell', 16.99, 150, 5);

-- =============================================
-- CONSULTAS DE VERIFICACIÓN
-- =============================================

-- Ver todas las categorías
SELECT * FROM categoria;

-- Ver todos los productos con nombre de categoría
SELECT p.id, p.nombre, p.descripcion, p.precio, p.stock, c.nombre as categoria_nombre
FROM producto p 
JOIN categoria c ON p.categoria_id = c.id
ORDER BY p.nombre;

-- Contar productos por categoría
SELECT c.nombre, COUNT(p.id) as total_productos
FROM categoria c
LEFT JOIN producto p ON c.id = p.categoria_id
GROUP BY c.id, c.nombre
ORDER BY total_productos DESC;

