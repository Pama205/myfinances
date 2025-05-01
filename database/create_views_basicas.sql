CREATE VIEW vw_tasas AS
SELECT 
	t.id AS tasa_id,
   m1.nombre AS moneda_base,
   m2.nombre AS moneda_relacionada,
   CONCAT(m1.codigo,' / ',m2.codigo) AS referencia,
   tt.nombre AS tipo_cambio,
   tt.codigo AS codigo_cambio,
   t.fecha AS fecha_tasa,
   t.costo AS tasa
FROM
   tasas t
LEFT JOIN
   tipos_tasas tt ON t.tipo_tasa_id = tt.id
LEFT JOIN
   monedas_relacionadas mr ON t.moneda_relacionada_id = mr.id
LEFT JOIN
    monedas m1 ON mr.moneda_base_id = m1.id
LEFT JOIN
    monedas m2 ON mr.moneda_relacionada_id = m2.id;

