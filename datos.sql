USE HorariosJS;

select * from Paises;
INSERT INTO Paises (Nombre)
VALUES ('Honduras');

SELECT * FROM Region;
INSERT INTO Region (PaisId, Nombre)
VALUES 
(1, 'Zona Centro'),
(1, 'Zona Sur'),
(1, 'Zona Norte'),
(1, 'Zona Occidental'),
(1, 'Zona Oriental');

SELECT * FROM ClaseDia;
INSERT INTO ClaseDia (Tipo)
VALUES 
('Laborable'),
('Sábado'),
('Domingo'),
('Feriado');

SELECT * FROM Periodos;
INSERT INTO Periodos (Descripcion)
VALUES 
('Período de punta'),
('Período intermedio'),
('Período de Valle');

SELECT * FROM Feriados;
INSERT INTO Feriados (PaisId, Descripcion, FechaFeriado, EsNacional)
VALUES 
(1, 'Año Nuevo', '2023-01-01', TRUE),
(1, 'Día del Trabajador', '2023-05-01', TRUE),
(1, 'Feriado Nacional por el Día de la Independencia', '2023-09-15', TRUE),
(1, 'Navidad', '2023-12-25', TRUE);

SELECT * FROM RangosHorarios;
INSERT INTO RangosHorarios (PeriodoId, HoraInicio, HoraFin)
VALUES 
(1, '17:00:00', '20:00:00'),  -- Período de punta, 5:00 PM a 8:00 PM
(2, '08:00:00', '17:00:00'),  -- Período intermedio, 8:00 AM a 5:00 PM
(3, '00:00:00', '08:00:00');  -- Período de Valle, 12:00 AM a 8:00 AM


SELECT * FROM DiasEspeciales;
INSERT INTO DiasEspeciales (RegionId, Descripcion, Fecha)
VALUES 
(1, 'Festival de la Ciudad - Centro', '2023-09-10'),  -- Ejemplo para la Zona Centro
(2, 'Celebración Marítima - Sur', '2023-10-15'),     -- Ejemplo para la Zona Sur
(3, 'Feria del Café - Norte', '2023-11-05'),         -- Ejemplo para la Zona Norte
(4, 'Día del Maíz - Occidental', '2023-08-20'),      -- Ejemplo para la Zona Occidental
(5, 'Festival de la Orquídea - Oriental', '2023-07-03'); -- Ejemplo para la Zona Oriental




-- Estableciendo precios para los días especiales
INSERT INTO PreciosEnergiaPorHorario (ClaseDiaId, RangoHorarioId, RegionId, DiasEspecialesId, Precio)
VALUES 
(NULL, 1, 1, 1, 15.50),  -- Precio en el periodo de punta para el Festival de la Ciudad - Centro
(NULL, 2, 1, 1, 13.00),  -- Precio en el periodo intermedio para el Festival de la Ciudad - Centro
(NULL, 3, 1, 1, 10.00),  -- Precio en el periodo de valle para el Festival de la Ciudad - Centro

(NULL, 1, 2, 2, 16.00),  -- Precio en el periodo de punta para la Celebración Marítima - Sur
(NULL, 2, 2, 2, 13.50),  -- Precio en el periodo intermedio para la Celebración Marítima - Sur
(NULL, 3, 2, 2, 10.50),  -- Precio en el periodo de valle para la Celebración Marítima - Sur

-- y así sucesivamente para los demás días especiales y regiones...

-- Estableciendo precios regulares para días laborables (como ejemplo)
(1, 1, 1, NULL, 14.50),  -- Precio en el periodo de punta para días laborables en Zona Centro
(1, 2, 1, NULL, 12.00),  -- Precio en el periodo intermedio para días laborables en Zona Centro
(1, 3, 1, NULL, 9.50);   -- Precio en el periodo de valle para días laborables en Zona Centro



-- Precios para los sábados (usando el ClaseDiaId 2 como referencia para sábados)

-- Zona Centro
INSERT INTO PreciosEnergiaPorHorario (ClaseDiaId, RangoHorarioId, RegionId, DiasEspecialesId, FeriadoId, Precio)
VALUES 
(2, 1, 1, NULL, NULL, 13.50),  -- Precio en el periodo de punta para sábados en Zona Centro
(2, 2, 1, NULL, NULL, 11.00),  -- Precio en el periodo intermedio para sábados en Zona Centro
(2, 3, 1, NULL, NULL, 8.50);   -- Precio en el periodo de valle para sábados en Zona Centro


-- Zona Sur
INSERT INTO PreciosEnergiaPorHorario (ClaseDiaId, RangoHorarioId, RegionId, Precio)
VALUES 
(2, 1, 2, NULL,NULL, 14.00),  
(2, 2, 2, NULL,NULL, 11.50),  
(2, 3, 2, NULL,NULL, 9.00);

-- Y así sucesivamente para las demás zonas...

-- Precios para los domingos (usando el ClaseDiaId 3 como referencia para domingos)

-- Zona Centro
INSERT INTO PreciosEnergiaPorHorario (ClaseDiaId, RangoHorarioId, RegionId, Precio)
VALUES 
(3, 1, 1,  12.50),  
(3, 2, 1, 10.00),  
(3, 3, 1, 8.00);

-- Zona Sur
INSERT INTO PreciosEnergiaPorHorario (ClaseDiaId, RangoHorarioId, RegionId, Precio)
VALUES 
(3, 1, 2, 13.00),  
(3, 2, 2, 10.50),  
(3, 3, 2, 8.50);

-- Y así sucesivamente para las demás zonas...

-- Ahora, para los feriados, supongamos que tienes un feriado con FeriadoId 1. Estableceríamos precios de la siguiente manera:

-- Zona Centro para FeriadoId 1
INSERT INTO PreciosEnergiaPorHorario (ClaseDiaId, RangoHorarioId, RegionId, FeriadoId, Precio)
VALUES 
(NULL, 1, 1, 1, 15.00),  
(NULL, 2, 1, 1, 12.50),  
(NULL, 3, 1, 1, 10.50);

-- Zona Sur para FeriadoId 1
INSERT INTO PreciosEnergiaPorHorario (ClaseDiaId, RangoHorarioId, RegionId, FeriadoId, Precio)
VALUES 
(NULL, 1, 2, 1, 15.50),  
(NULL, 2, 2, 1, 13.00),  
(NULL, 3, 2, 1, 11.00);

-- Y así sucesivamente para las demás zonas y feriados...




