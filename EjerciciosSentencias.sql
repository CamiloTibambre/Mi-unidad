DROP DATABASE IF EXISTS TiendaTech;
CREATE DATABASE TiendaTech;
USE TiendaTech;



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




INSERT INTO Categorias (nombre, descripcion) VALUES
('Laptops',      'Computadoras portátiles'),
('Smartphones',  'Teléfonos inteligentes'),
('Accesorios',   'Periféricos y cables'),
('Monitores',    'Pantallas para escritorio'),
('Audio',        'Audífonos y bocinas');

INSERT INTO Clientes (nombre, ciudad, email, fecha_registro) VALUES
('Ana García',      'Bogotá',      'ana@mail.com',    '2023-01-15'),
('Luis Martínez',   'Medellín',    'luis@mail.com',   '2023-03-22'),
('María López',     'Cali',        'maria@mail.com',  '2023-05-10'),
('Carlos Pérez',    'Bogotá',      'carlos@mail.com', '2023-07-04'),
('Sofía Ramírez',   'Barranquilla','sofia@mail.com',  '2023-08-19'),
('Diego Torres',    'Bogotá',      'diego@mail.com',  '2023-09-30'),
('Laura Castillo',  'Medellín',    'laura@mail.com',  '2024-01-05'),
('Juan Moreno',     'Cali',        'juan@mail.com',   '2024-02-14');

INSERT INTO Empleados (nombre, cargo, salario, id_supervisor) VALUES
('Ricardo Vargas',  'Gerente',         8500000, NULL),
('Paola Nieto',     'Vendedor',        3200000, 1),
('Andrés Rueda',    'Vendedor',        3100000, 1),
('Camila Ossa',     'Soporte',         2900000, 1),
('Felipe Gómez',    'Vendedor',        3300000, 1);

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




-- ── 1. WHERE ────────────────────────────────────────────────────
SELECT * FROM Clientes WHERE ciudad = 'Bogotá';

SELECT nombre, precio FROM Productos WHERE precio > 1000000;

SELECT * FROM Pedidos WHERE estado = 'Entregado' AND fecha >= '2024-01-01';

-- ── 2. DISTINCT ─────────────────────────────────────────────────
SELECT DISTINCT ciudad FROM Clientes;

SELECT DISTINCT estado FROM Pedidos;

-- ── 3. ORDER BY ─────────────────────────────────────────────────
SELECT nombre, precio FROM Productos ORDER BY precio DESC;

SELECT nombre, ciudad FROM Clientes ORDER BY nombre ASC;

-- ── 4. LIMIT ────────────────────────────────────────────────────
SELECT nombre, precio FROM Productos ORDER BY precio DESC LIMIT 5;

SELECT * FROM Pedidos ORDER BY fecha DESC LIMIT 3;

-- ── 5. COUNT ────────────────────────────────────────────────────
SELECT COUNT(*) AS total_clientes FROM Clientes;

SELECT id_cliente, COUNT(*) AS total_pedidos
FROM Pedidos
GROUP BY id_cliente;

-- ── 6. SUM ──────────────────────────────────────────────────────
SELECT id_pedido,
       SUM(cantidad * precio_unitario) AS total_pedido
FROM DetallePedido
GROUP BY id_pedido;

SELECT SUM(cantidad * precio_unitario) AS ingresos_totales
FROM DetallePedido;

-- ── 7. AVG ──────────────────────────────────────────────────────
SELECT AVG(precio) AS precio_promedio FROM Productos;

SELECT AVG(salario) AS salario_promedio FROM Empleados;

-- ── 8. MIN / MAX ────────────────────────────────────────────────
SELECT MIN(precio) AS mas_barato, MAX(precio) AS mas_caro FROM Productos;

SELECT MIN(fecha) AS primer_pedido, MAX(fecha) AS ultimo_pedido FROM Pedidos;

-- ── 9. GROUP BY ─────────────────────────────────────────────────
SELECT id_categoria, COUNT(*) AS cantidad_productos
FROM Productos
GROUP BY id_categoria;

SELECT id_empleado, SUM(cantidad * precio_unitario) AS ventas_totales
FROM Pedidos p
JOIN DetallePedido dp ON p.id_pedido = dp.id_pedido
GROUP BY id_empleado;

-- ── 10. INNER JOIN ───────────────────────────────────────────────
SELECT p.id_pedido, c.nombre AS cliente, p.fecha, p.estado
FROM Pedidos p
INNER JOIN Clientes c ON p.id_cliente = c.id_cliente;

SELECT dp.id_pedido, pr.nombre AS producto, dp.cantidad, dp.precio_unitario,
       (dp.cantidad * dp.precio_unitario) AS subtotal
FROM DetallePedido dp
INNER JOIN Productos pr ON dp.id_producto = pr.id_producto;

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

SELECT pr.nombre AS producto, pr.precio, cat.nombre AS categoria
FROM Productos pr
JOIN Categorias cat ON pr.id_categoria = cat.id_categoria
ORDER BY cat.nombre;

-- ── 11. SET (UPDATE con SET) ──────────────────────────────────────
UPDATE Productos
SET precio = 3000000
WHERE id_producto = 2;

UPDATE Pedidos
SET estado = 'Entregado'
WHERE id_pedido = 4;

UPDATE Empleados
SET salario = salario * 1.10
WHERE cargo = 'Vendedor';






-- ============================================================
-- BASE DE DATOS Y SENTENCIAS DE LANCHEROS XDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
-- ============================================================


DROP DATABASE IF EXISTS ClinicaSalud;
CREATE DATABASE ClinicaSalud;
USE ClinicaSalud;



CREATE TABLE Especialidades (
    id_especialidad INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    descripcion VARCHAR(150)
);

CREATE TABLE Pacientes (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    ciudad VARCHAR(50),
    telefono VARCHAR(20),
    fecha_nacimiento DATE
);

CREATE TABLE Medicos (
    id_medico INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    cargo VARCHAR(50),
    salario DECIMAL(10,2),
    id_jefe INT,
    FOREIGN KEY (id_jefe) REFERENCES Medicos(id_medico)
);

CREATE TABLE Medicamentos (
    id_medicamento INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    precio DECIMAL(10,2),
    stock INT,
    id_especialidad INT,
    FOREIGN KEY (id_especialidad) REFERENCES Especialidades(id_especialidad)
);

CREATE TABLE Consultas (
    id_consulta INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT,
    id_medico INT,
    fecha DATE,
    estado VARCHAR(30),
    FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES Medicos(id_medico)
);

CREATE TABLE DetalleConsulta (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_consulta INT,
    id_medicamento INT,
    cantidad INT,
    precio_unitario DECIMAL(10,2),
    FOREIGN KEY (id_consulta) REFERENCES Consultas(id_consulta),
    FOREIGN KEY (id_medicamento) REFERENCES Medicamentos(id_medicamento)
);



INSERT INTO Especialidades (nombre, descripcion) VALUES
('Cardiología',     'Enfermedades del corazón y sistema circulatorio'),
('Pediatría',       'Atención médica a niños y adolescentes'),
('Dermatología',    'Enfermedades de la piel'),
('Neurología',      'Enfermedades del sistema nervioso'),
('Traumatología',   'Lesiones de huesos y articulaciones');

INSERT INTO Pacientes (nombre, ciudad, telefono, fecha_nacimiento) VALUES
('Valentina Ríos',      'Bogotá',       '3101234567', '1990-04-12'),
('Camilo Herrera',      'Medellín',     '3209876543', '1985-07-23'),
('Isabel Fuentes',      'Cali',         '3154567890', '2000-11-05'),
('Sebastián Mora',      'Bogotá',       '3187654321', '1978-02-28'),
('Natalia Ospina',      'Bucaramanga',  '3123456789', '1995-09-17'),
('Andrés Cárdenas',     'Bogotá',       '3165432109', '1982-12-03'),
('Luisa Fernanda Gil',  'Medellín',     '3198765432', '2003-06-30'),
('Miguel Ángel Soto',   'Cali',         '3112345678', '1970-01-19');

INSERT INTO Medicos (nombre, cargo, salario, id_jefe) VALUES
('Dr. Jorge Salcedo',   'Director Médico',   12000000, NULL),
('Dra. Patricia Luna',  'Cardiólogo',         8500000, 1),
('Dr. Hernán Vásquez',  'Pediatra',           7800000, 1),
('Dra. Sandra Mejía',   'Dermatóloga',        7600000, 1),
('Dr. Carlos Ibáñez',   'Neurólogo',          8200000, 1);

INSERT INTO Medicamentos (nombre, precio, stock, id_especialidad) VALUES
('Aspirina 500mg',          8000,  200, 1),
('Losartán 50mg',          15000,  150, 1),
('Atorvastatina 20mg',     22000,  120, 1),
('Amoxicilina 500mg',      12000,  300, 2),
('Paracetamol Pediátrico',  9000,  250, 2),
('Ibuprofeno 200mg',        7500,  180, 2),
('Hidrocortisona Crema',   18000,   90, 3),
('Clotrimazol Crema',      14000,  110, 3),
('Tretinoína 0.05%',       35000,   60, 3),
('Levodopa 250mg',         45000,   80, 4),
('Gabapentina 300mg',      28000,   95, 4),
('Diclofenaco 75mg',       11000,  160, 5),
('Calcio + Vitamina D',    20000,  200, 5),
('Meloxicam 15mg',         13000,  140, 5);

INSERT INTO Consultas (id_paciente, id_medico, fecha, estado) VALUES
(1, 2, '2024-01-08',  'Atendida'),
(2, 3, '2024-01-20',  'Atendida'),
(3, 4, '2024-02-05',  'Atendida'),
(4, 5, '2024-02-18',  'Pendiente'),
(1, 3, '2024-03-10',  'Atendida'),
(5, 2, '2024-03-25',  'Cancelada'),
(6, 4, '2024-04-07',  'Atendida'),
(7, 5, '2024-04-22',  'Pendiente'),
(2, 2, '2024-05-03',  'Atendida'),
(8, 3, '2024-05-18',  'Atendida');

INSERT INTO DetalleConsulta (id_consulta, id_medicamento, cantidad, precio_unitario) VALUES
(1,  1, 2,  8000),
(1,  2, 1, 15000),
(2,  4, 1, 12000),
(3,  7, 1, 18000),
(3,  8, 1, 14000),
(4, 10, 1, 45000),
(5,  5, 2,  9000),
(5,  6, 1,  7500),
(6,  4, 3, 12000),
(7,  9, 1, 35000),
(7, 12, 2, 11000),
(8, 13, 2, 20000),
(9,  1, 1,  8000),
(9,  3, 1, 22000),
(10, 5, 2,  9000),
(10,14, 1, 13000);



-- ── 1. WHERE ────────────────────────────────────────────────────
SELECT * FROM Pacientes WHERE ciudad = 'Bogotá';

SELECT nombre, precio FROM Medicamentos WHERE precio > 20000;

SELECT * FROM Consultas WHERE estado = 'Atendida' AND fecha >= '2024-03-01';

-- ── 2. DISTINCT ─────────────────────────────────────────────────
SELECT DISTINCT ciudad FROM Pacientes;

SELECT DISTINCT estado FROM Consultas;

-- ── 3. ORDER BY ─────────────────────────────────────────────────
SELECT nombre, precio FROM Medicamentos ORDER BY precio DESC;

SELECT nombre, ciudad FROM Pacientes ORDER BY nombre ASC;

-- ── 4. LIMIT ────────────────────────────────────────────────────
SELECT nombre, precio FROM Medicamentos ORDER BY precio DESC LIMIT 5;

SELECT * FROM Consultas ORDER BY fecha DESC LIMIT 3;

-- ── 5. COUNT ────────────────────────────────────────────────────
SELECT COUNT(*) AS total_pacientes FROM Pacientes;

SELECT id_paciente, COUNT(*) AS total_consultas
FROM Consultas
GROUP BY id_paciente;

-- ── 6. SUM ──────────────────────────────────────────────────────
SELECT id_consulta,
       SUM(cantidad * precio_unitario) AS total_consulta
FROM DetalleConsulta
GROUP BY id_consulta;

SELECT SUM(cantidad * precio_unitario) AS ingresos_totales
FROM DetalleConsulta;

-- ── 7. AVG ──────────────────────────────────────────────────────
SELECT AVG(precio) AS precio_promedio FROM Medicamentos;

SELECT AVG(salario) AS salario_promedio FROM Medicos;

-- ── 8. MIN / MAX ────────────────────────────────────────────────
SELECT MIN(precio) AS mas_barato, MAX(precio) AS mas_caro FROM Medicamentos;

SELECT MIN(fecha) AS primera_consulta, MAX(fecha) AS ultima_consulta FROM Consultas;

-- ── 9. GROUP BY ─────────────────────────────────────────────────
SELECT id_especialidad, COUNT(*) AS cantidad_medicamentos
FROM Medicamentos
GROUP BY id_especialidad;

SELECT id_medico, SUM(cantidad * precio_unitario) AS ingresos_generados
FROM Consultas c
JOIN DetalleConsulta dc ON c.id_consulta = dc.id_consulta
GROUP BY id_medico;

-- ── 10. INNER JOIN ───────────────────────────────────────────────
SELECT c.id_consulta, p.nombre AS paciente, c.fecha, c.estado
FROM Consultas c
INNER JOIN Pacientes p ON c.id_paciente = p.id_paciente;

SELECT dc.id_consulta, m.nombre AS medicamento, dc.cantidad, dc.precio_unitario,
       (dc.cantidad * dc.precio_unitario) AS subtotal
FROM DetalleConsulta dc
INNER JOIN Medicamentos m ON dc.id_medicamento = m.id_medicamento;

SELECT p.nombre AS paciente,
       med.nombre AS medico,
       m.nombre AS medicamento,
       dc.cantidad,
       dc.precio_unitario
FROM Consultas c
JOIN Pacientes p          ON c.id_paciente    = p.id_paciente
JOIN Medicos med          ON c.id_medico      = med.id_medico
JOIN DetalleConsulta dc   ON c.id_consulta    = dc.id_consulta
JOIN Medicamentos m       ON dc.id_medicamento = m.id_medicamento
ORDER BY c.id_consulta;

SELECT m.nombre AS medicamento, m.precio, e.nombre AS especialidad
FROM Medicamentos m
JOIN Especialidades e ON m.id_especialidad = e.id_especialidad
ORDER BY e.nombre;

-- ── 11. SET (UPDATE con SET) ──────────────────────────────────────
UPDATE Medicamentos
SET precio = 10000
WHERE id_medicamento = 1;

UPDATE Consultas
SET estado = 'Atendida'
WHERE id_consulta = 4;

UPDATE Medicos
SET salario = salario * 1.10
WHERE cargo != 'Director Médico';
