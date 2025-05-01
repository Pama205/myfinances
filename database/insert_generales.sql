
USE myfinances;

-- Insertar monedas
INSERT INTO monedas (nombre, simbolo, codigo) VALUES 
('Bolívar Venezolano', 'Bs', 'VES'),
('Dólar Americano', '$', 'USD'),
('Euro', '€', 'EUR'),
('Tether USD', 'USDT', 'USDT');

-- Obtener los IDs de las monedas
SET @VES_ID = (SELECT id FROM monedas WHERE codigo = 'VES');
SET @USD_ID = (SELECT id FROM monedas WHERE codigo = 'USD');
SET @EUR_ID = (SELECT id FROM monedas WHERE codigo = 'EUR');
SET @USDT_ID = (SELECT id FROM monedas WHERE codigo = 'USDT');

-- Insertar monedas_relacionadas (relaciones con el Bolívar)
INSERT INTO monedas_relacionadas (moneda_base_id, moneda_relacionada_id) VALUES 
( @USD_ID, @VES_ID ), -- Dólar - Bolívar
( @EUR_ID, @VES_ID ), -- Euro - Bolívar
( @USDT_ID, @VES_ID ); -- USDT - Bolívar

-- Insertar tipos de tasas
INSERT INTO tipos_tasas (nombre, descripcion, codigo) VALUES
('Banco Central', 'Tasa oficial del Banco Central de Venezuela', 'BCV'),
('DolarToday', 'Tasa promedio publicada por DolarToday', 'DTD'),
('Binance', 'Tasa de cambio de Binance', 'BIN');

-- Insertar tasas (ejemplo con fecha de hoy, recuerda actualizar las tasas)
INSERT INTO tasas (moneda_relacionada_id, fecha, costo, tipo_tasa_id) VALUES 
(1, CURDATE(), 25.000, 1), -- Dólar BCV en Bolívares (tipo_tasa_id = 1, Banco Central)
(1, CURDATE(), 26.500, 2), -- Dólar DolarToday en Bolívares (tipo_tasa_id = 2, DolarToday)
(2, CURDATE(), 27.000, 1), -- Euro BCV en Bolívares (tipo_tasa_id = 1, Banco Central)
(2, CURDATE(), 28.500, 2), -- Euro paralelo en Bolívares (tipo_tasa_id = 2, DolarToday) 
(3, CURDATE(), 25.800, 3); -- USDT Binance en Bolívares (tipo_tasa_id = 3, Binance)


-- Insertar categorías de transacciones
INSERT INTO categorias (nombre, descripcion, tipo) VALUES
('Alimentación', 'Gastos en comida y bebidas', 'gasto'),
('Transporte', 'Gastos en transporte público o privado', 'gasto'),
('Vivienda', 'Gastos de alquiler, hipoteca o servicios', 'gasto'),
('Salud', 'Gastos médicos, medicinas, etc.', 'gasto'),
('Educación', 'Gastos en educación, cursos, libros', 'gasto'),
('Entretenimiento', 'Gastos en ocio, cine, restaurantes', 'gasto'),
('Salario', 'Ingresos por salario', 'ingreso'),
('Servicios', 'Ingresos por servicios profesionales', 'ingreso'),
('Inversiones', 'Ingresos por inversiones', 'ingreso'),
('Otros', 'Cualquier otra categoría', 'gasto');


-- Insertar etiquetas (opcional)
INSERT INTO etiquetas (nombre, nombre_corto) VALUES
('Necesario', 'NEC'),
('Superfluo', 'SUP'),
('Ocasional', 'OCA'),
('Fijo', 'FIJ'),
('Variable', 'VAR');