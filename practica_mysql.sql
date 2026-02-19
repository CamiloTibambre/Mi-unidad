-- ============================================================
--  BASE DE DATOS: TiendaTech
--  Para practicar sentencias MySQL
-- ============================================================

DROP DATABASE IF EXISTS TiendaTech;
CREATE DATABASE TiendaTech;
USE TiendaTech;

-- ============================================================
-- 1. CREACIÓN DE TABLAS
-- ============================================================

CREATE TABLE Categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(150)
);

CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    ciudad VARCHAR(50),
    email VARCHAR(80),
    fecha_registro DATE
);

CREATE TABLE Empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    cargo VARCHAR(50),
    salario DECIMAL(10,2),
    id_supervisor INT,
    FOREIGN KEY (id_supervisor) REFERENCES Empleados(id_empleado)
);

CREATE TABLE Productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    precio DECIMAL(10,2),
    stock INT,
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria)
);

CREATE TABLE Pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_empleado INT,
    fecha DATE,
    estado VARCHAR(30),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado)
);

CREATE TABLE DetallePedido (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_producto INT,
    cantidad INT,
    precio_unitario DECIMAL(10,2),
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

-- ============================================================
-- 2. INSERT INTO — Carga de datos
-- ============================================================

-- Categorias
INSERT INTO Categorias (nombre, descripcion) VALUES
('Laptops',      'Computadoras portátiles'),
('Smartphones',  'Teléfonos inteligentes'),
('Accesorios',   'Periféricos y cables'),
('Monitores',    'Pantallas para escritorio'),
('Audio',        'Audífonos y bocinas');

-- Clientes
INSERT INTO Clientes (nombre, ciudad, email, fecha_registro) VALUES
('Ana García',      'Bogotá',      'ana@mail.com',    '2023-01-15'),
('Luis Martínez',   'Medellín',    'luis@mail.com',   '2023-03-22'),
('María López',     'Cali',        'maria@mail.com',  '2023-05-10'),
('Carlos Pérez',    'Bogotá',      'carlos@mail.com', '2023-07-04'),
('Sofía Ramírez',   'Barranquilla','sofia@mail.com',  '2023-08-19'),
('Diego Torres',    'Bogotá',      'diego@mail.com',  '2023-09-30'),
('Laura Castillo',  'Medellín',    'laura@mail.com',  '2024-01-05'),
('Juan Moreno',     'Cali',        'juan@mail.com',   '2024-02-14');

-- Empleados
INSERT INTO Empleados (nombre, cargo, salario, id_supervisor) VALUES
('Ricardo Vargas',  'Gerente',         8500000, NULL),
('Paola Nieto',     'Vendedor',        3200000, 1),
('Andrés Rueda',    'Vendedor',        3100000, 1),
('Camila Ossa',     'Soporte',         2900000, 1),
('Felipe Gómez',    'Vendedor',        3300000, 1);

-- Productos
INSERT INTO Productos (nombre, precio, stock, id_categoria) VALUES
('Laptop Dell Inspiron',  3200000, 15, 1),
('Laptop HP Pavilion',    2800000, 20, 1),
('Laptop MacBook Air',    6500000,  8, 1),
('iPhone 15',             4200000, 30, 2),
('Samsung Galaxy S24',    3800000, 25, 2),
('Xiaomi Redmi Note 13',  1200000, 40, 2),
('Mouse Logitech MX',      180000, 50, 3),
('Teclado Mecánico Redragon', 250000, 35, 3),
('Cable USB-C 2m',          25000, 100, 3),
('Monitor LG 27"',         950000, 12, 4),
('Monitor Samsung 24"',    720000, 18, 4),
('Audífonos Sony WH-1000', 1100000, 22, 5),
('Audífonos JBL Tune 510',  280000, 45, 5),
('Bocina JBL Flip 6',       560000, 30, 5);

-- Pedidos
INSERT INTO Pedidos (id_cliente, id_empleado, fecha, estado) VALUES
(1, 2, '2024-01-10', 'Entregado'),
(2, 3, '2024-01-15', 'Entregado'),
(3, 2, '2024-02-01', 'Entregado'),
(4, 5, '2024-02-20', 'Pendiente'),
(1, 3, '2024-03-05', 'Entregado'),
(5, 2, '2024-03-18', 'Cancelado'),
(6, 4, '2024-04-02', 'Entregado'),
(7, 5, '2024-04-15', 'Pendiente'),
(2, 2, '2024-05-01', 'Entregado'),
(8, 3, '2024-05-20', 'Entregado');

-- DetallePedido
INSERT INTO DetallePedido (id_pedido, id_producto, cantidad, precio_unitario) VALUES
(1,  1, 1, 3200000),
(1,  7, 2,  180000),
(2,  4, 1, 4200000),
(3,  2, 1, 2800000),
(3, 12, 1, 1100000),
(4,  3, 1, 6500000),
(5,  5, 1, 3800000),
(5, 13, 2,  280000),
(6,  6, 2, 1200000),
(7, 10, 1,  950000),
(7,  8, 1,  250000),
(8, 11, 2,  720000),
(9,  1, 1, 3200000),
(9,  9, 3,   25000),
(10, 4, 1, 4200000),
(10,14, 1,  560000);

-- ============================================================
-- 3. EJEMPLOS DE SENTENCIAS
-- ============================================================

-- ── WHERE ────────────────────────────────────────────────────
-- Clientes de Bogotá
SELECT * FROM Clientes WHERE ciudad = 'Bogotá';

-- Productos con precio mayor a 1.000.000
SELECT nombre, precio FROM Productos WHERE precio > 1000000;

-- Pedidos entregados en 2024
SELECT * FROM Pedidos WHERE estado = 'Entregado' AND fecha >= '2024-01-01';

-- ── DISTINCT ─────────────────────────────────────────────────
-- Ciudades únicas de clientes
SELECT DISTINCT ciudad FROM Clientes;

-- Estados únicos de pedidos
SELECT DISTINCT estado FROM Pedidos;

-- ── ORDER BY ─────────────────────────────────────────────────
-- Productos ordenados de más caro a más barato
SELECT nombre, precio FROM Productos ORDER BY precio DESC;

-- Clientes en orden alfabético
SELECT nombre, ciudad FROM Clientes ORDER BY nombre ASC;

-- ── LIMIT ────────────────────────────────────────────────────
-- Los 5 productos más caros
SELECT nombre, precio FROM Productos ORDER BY precio DESC LIMIT 5;

-- Los 3 pedidos más recientes
SELECT * FROM Pedidos ORDER BY fecha DESC LIMIT 3;

-- ── COUNT ────────────────────────────────────────────────────
-- Total de clientes registrados
SELECT COUNT(*) AS total_clientes FROM Clientes;

-- Cuántos pedidos tiene cada cliente
SELECT id_cliente, COUNT(*) AS total_pedidos
FROM Pedidos
GROUP BY id_cliente;

-- ── SUM ──────────────────────────────────────────────────────
-- Ingresos totales por pedido
SELECT id_pedido,
       SUM(cantidad * precio_unitario) AS total_pedido
FROM DetallePedido
GROUP BY id_pedido;

-- Total de ingresos de toda la tienda
SELECT SUM(cantidad * precio_unitario) AS ingresos_totales
FROM DetallePedido;

-- ── AVG ──────────────────────────────────────────────────────
-- Precio promedio de todos los productos
SELECT AVG(precio) AS precio_promedio FROM Productos;

-- Salario promedio de los empleados
SELECT AVG(salario) AS salario_promedio FROM Empleados;

-- ── MIN / MAX ────────────────────────────────────────────────
-- Producto más barato y más caro
SELECT MIN(precio) AS mas_barato, MAX(precio) AS mas_caro FROM Productos;

-- Primer y último pedido por fecha
SELECT MIN(fecha) AS primer_pedido, MAX(fecha) AS ultimo_pedido FROM Pedidos;

-- ── GROUP BY ─────────────────────────────────────────────────
-- Cantidad de productos por categoría
SELECT id_categoria, COUNT(*) AS cantidad_productos
FROM Productos
GROUP BY id_categoria;

-- Total de ventas por empleado
SELECT id_empleado, SUM(cantidad * precio_unitario) AS ventas_totales
FROM Pedidos p
JOIN DetallePedido dp ON p.id_pedido = dp.id_pedido
GROUP BY id_empleado;

-- ── INNER JOIN ───────────────────────────────────────────────
-- Pedidos con nombre del cliente
SELECT p.id_pedido, c.nombre AS cliente, p.fecha, p.estado
FROM Pedidos p
INNER JOIN Clientes c ON p.id_cliente = c.id_cliente;

-- Detalle de pedidos con nombre de producto
SELECT dp.id_pedido, pr.nombre AS producto, dp.cantidad, dp.precio_unitario,
       (dp.cantidad * dp.precio_unitario) AS subtotal
FROM DetallePedido dp
INNER JOIN Productos pr ON dp.id_producto = pr.id_producto;

-- Pedido completo: cliente + empleado + productos
SELECT c.nombre AS cliente,
       e.nombre AS vendedor,
       pr.nombre AS producto,
       dp.cantidad,
       dp.precio_unitario
FROM Pedidos p
JOIN Clientes c    ON p.id_cliente  = c.id_cliente
JOIN Empleados e   ON p.id_empleado = e.id_empleado
JOIN DetallePedido dp ON p.id_pedido = dp.id_pedido
JOIN Productos pr  ON dp.id_producto = pr.id_producto
ORDER BY p.id_pedido;

-- Productos con su categoría
SELECT pr.nombre AS producto, pr.precio, cat.nombre AS categoria
FROM Productos pr
JOIN Categorias cat ON pr.id_categoria = cat.id_categoria
ORDER BY cat.nombre;

-- ── SET (UPDATE con SET) ──────────────────────────────────────
-- Actualizar precio de un producto
UPDATE Productos
SET precio = 3000000
WHERE id_producto = 2;

-- Cambiar estado de un pedido
UPDATE Pedidos
SET estado = 'Entregado'
WHERE id_pedido = 4;

-- Aumentar 10% el salario de todos los vendedores
UPDATE Empleados
SET salario = salario * 1.10
WHERE cargo = 'Vendedor';

-- ── CONSULTAS COMBINADAS (GROUP BY + ORDER BY + HAVING) ───────
-- Categorías con más de 2 productos, ordenadas por cantidad
SELECT cat.nombre AS categoria, COUNT(pr.id_producto) AS cantidad
FROM Categorias cat
JOIN Productos pr ON cat.id_categoria = pr.id_categoria
GROUP BY cat.nombre
HAVING COUNT(pr.id_producto) > 2
ORDER BY cantidad DESC;

-- Top 3 clientes con más gasto total
SELECT c.nombre AS cliente,
       SUM(dp.cantidad * dp.precio_unitario) AS gasto_total
FROM Clientes c
JOIN Pedidos p      ON c.id_cliente  = p.id_cliente
JOIN DetallePedido dp ON p.id_pedido = dp.id_pedido
GROUP BY c.nombre
ORDER BY gasto_total DESC
LIMIT 3;

-- Promedio de ventas por ciudad del cliente
SELECT c.ciudad,
       COUNT(DISTINCT p.id_pedido)              AS num_pedidos,
       SUM(dp.cantidad * dp.precio_unitario)    AS total_ventas,
       AVG(dp.cantidad * dp.precio_unitario)    AS promedio_por_detalle
FROM Clientes c
JOIN Pedidos p        ON c.id_cliente  = p.id_cliente
JOIN DetallePedido dp ON p.id_pedido   = dp.id_pedido
WHERE p.estado = 'Entregado'
GROUP BY c.ciudad
ORDER BY total_ventas DESC;
