use HorariosJS;
SET @Hoy = CURDATE();
SET @InicioSemanaSiguiente = DATE_ADD(@Hoy, INTERVAL (7 - DAYOFWEEK(@Hoy) + 1) DAY);
SET @FinSemanaSiguiente = DATE_ADD(@InicioSemanaSiguiente, INTERVAL 6 DAY);

-- SET @InicioMesSiguiente = DATE_ADD(DATE_ADD(LAST_DAY(@Hoy), INTERVAL 1 DAY), INTERVAL 0 MONTH);
-- SET @FinMesSiguiente = LAST_DAY(@InicioMesSiguiente);

SELECT 
    p.Descripcion AS Periodo,
    rh.HoraInicio,
    rh.HoraFin,
    IF(cd.Tipo IS NULL, de.Descripcion, cd.Tipo) AS TipoDia,
    r.Nombre AS Region,
    pe.Precio
FROM
    PreciosEnergiaPorHorario pe
JOIN 
    RangosHorarios rh ON pe.RangoHorarioId = rh.Id
JOIN 
    Periodos p ON rh.PeriodoId = p.Id
JOIN 
    Region r ON pe.RegionId = r.RegionId
LEFT JOIN 
    ClaseDia cd ON pe.ClaseDiaId = cd.Id
LEFT JOIN 
    DiasEspeciales de ON pe.DiasEspecialesId = de.Id
WHERE 
    (pe.ClaseDiaId IS NOT NULL OR (pe.DiasEspecialesId IS NOT NULL AND de.Fecha BETWEEN @InicioSemanaSiguiente AND @FinSemanaSiguiente))
ORDER BY 
    r.Nombre, rh.HoraInicio, rh.HoraFin;
