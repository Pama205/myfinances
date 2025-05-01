-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS myfinances;

USE myfinances;

-- Crear la tabla monedas
CREATE TABLE monedas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    simbolo VARCHAR(10) NOT NULL,
    codigo VARCHAR(5) NOT NULL, 
    created_at TIMESTAMP NULL DEFAULT NULL,
    updated_at TIMESTAMP NULL DEFAULT NULL
);

-- Crear la tabla monedas_relacionadas
CREATE TABLE monedas_relacionadas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    moneda_base_id INT NOT NULL, 
    moneda_relacionada_id INT NOT NULL, 
    FOREIGN KEY (moneda_base_id) REFERENCES monedas(id),
    FOREIGN KEY (moneda_relacionada_id) REFERENCES monedas(id)
);

-- Crear la tabla tipos_tasas
CREATE TABLE tipos_tasas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    codigo VARCHAR(10) NULL DEFAULT NULL,
    descripcion TEXT,
    created_at TIMESTAMP NULL DEFAULT NULL,
    updated_at TIMESTAMP NULL DEFAULT NULL
);

-- Crear la tabla tasas
CREATE TABLE tasas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    moneda_relacionada_id INT NOT NULL, 
    fecha DATE NOT NULL,
    costo DECIMAL(15, 3) NOT NULL,
    tipo_tasa_id INT NOT NULL,
    created_at TIMESTAMP NULL DEFAULT NULL,
    updated_at TIMESTAMP NULL DEFAULT NULL,
    FOREIGN KEY (moneda_relacionada_id) REFERENCES monedas_relacionadas(id)
);

-- Crear la tabla usuarios
CREATE TABLE usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    contraseña VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NULL DEFAULT NULL,
    updated_at TIMESTAMP NULL DEFAULT NULL
);

-- Crear la tabla cuentas
CREATE TABLE cuentas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    tipo ENUM('banco', 'efectivo', 'otro') NOT NULL,
    saldo DECIMAL(15, 3) NOT NULL,
    moneda_id INT NOT NULL,
    created_at TIMESTAMP NULL DEFAULT NULL,
    updated_at TIMESTAMP NULL DEFAULT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (moneda_id) REFERENCES monedas(id)
);

-- Crear la tabla categorias
CREATE TABLE categorias (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    tipo ENUM('ingreso', 'gasto') NOT NULL, 
    created_at TIMESTAMP NULL DEFAULT NULL,
    updated_at TIMESTAMP NULL DEFAULT NULL
);

-- Crear la tabla transacciones
CREATE TABLE transacciones (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cuenta_id INT NOT NULL,
    fecha DATE NOT NULL,
    descripcion TEXT,
    monto DECIMAL(15, 3) NOT NULL,
    tipo ENUM('ingreso', 'gasto') NOT NULL,
    categoria_id INT, -- Permitir nulos para transacciones sin categoría 
    created_at TIMESTAMP NULL DEFAULT NULL,
    updated_at TIMESTAMP NULL DEFAULT NULL,
    FOREIGN KEY (cuenta_id) REFERENCES cuentas(id),
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

-- Crear la tabla deudas
CREATE TABLE deudas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    acreedor VARCHAR(255) NOT NULL,
    monto_inicial DECIMAL(15, 3) NOT NULL,
    monto DECIMAL(15, 3) NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    moneda_id INT NOT NULL, 
    created_at TIMESTAMP NULL DEFAULT NULL,
    updated_at TIMESTAMP NULL DEFAULT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (moneda_id) REFERENCES monedas(id)
);

-- Crear la tabla ahorros
CREATE TABLE ahorros (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    meta DECIMAL(15, 3) NOT NULL,
    monto_actual DECIMAL(15, 3) NOT NULL,
    moneda_id INT NOT NULL,
    created_at TIMESTAMP NULL DEFAULT NULL,
    updated_at TIMESTAMP NULL DEFAULT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (moneda_id) REFERENCES monedas(id)
);

-- Crear la tabla inversiones
CREATE TABLE inversiones (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    tipo VARCHAR(255) NOT NULL,
    descripcion TEXT,
    monto DECIMAL(15, 3) NOT NULL,
    fecha_inicio DATE NOT NULL,
    moneda_id INT NOT NULL,
    created_at TIMESTAMP NULL DEFAULT NULL,
    updated_at TIMESTAMP NULL DEFAULT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (moneda_id) REFERENCES monedas(id)
);

-- Crear la tabla etiquetas (opcional)
CREATE TABLE etiquetas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    nombre_corto VARCHAR(10) NOT NULL,
    created_at TIMESTAMP NULL DEFAULT NULL,
    updated_at TIMESTAMP NULL DEFAULT NULL
);

-- Crear la tabla transacciones_etiquetas (opcional)
CREATE TABLE transacciones_etiquetas (
    transaccion_id INT NOT NULL,
    etiqueta_id INT NOT NULL,
    FOREIGN KEY (transaccion_id) REFERENCES transacciones(id),
    FOREIGN KEY (etiqueta_id) REFERENCES etiquetas(id)
);