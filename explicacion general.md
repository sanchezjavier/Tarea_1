### 1. `Paises`
**Estructura**:
```sql
CREATE TABLE Paises (
    PaisId INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL
);
```
**Explicación**: 
Esta tabla permite registrar diferentes países, lo que es esencial considerando que se quiere manejar la información por región y tener en cuenta días feriados específicos de cada país. Al asignar a cada país un ID único, se puede hacer referencia a este en otras tablas, lo que facilita las consultas y la estructuración de datos.

### 2. `Region`
**Estructura**:
```sql
CREATE TABLE Region (
    RegionId INT PRIMARY KEY AUTO_INCREMENT,
    PaisId INT,
    Nombre VARCHAR(100) NOT NULL,
    FOREIGN KEY (PaisId) REFERENCES Paises(PaisId)
);
```
**Explicación**: 
Las regiones son subdivisiones de un país y pueden tener características específicas, como tarifas eléctricas particulares. Al vincular las regiones con un país mediante `PaisId`, podemos tener múltiples regiones por país y asignar tarifas o condiciones especiales a cada región.

### 3. `ClaseDia`
**Estructura**:
```sql
CREATE TABLE ClaseDia (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Tipo ENUM('Laborable', 'Sábado', 'Domingo', 'Feriado') NOT NULL
);
```
**Explicación**: 
Esta tabla categoriza los días en tipos específicos (Laborable, Sábado, Domingo, Feriado). Esta clasificación es crucial porque las tarifas eléctricas pueden variar según el tipo de día. Por ejemplo, un día laborable podría tener una tarifa diferente a un domingo o feriado.

### 4. `Periodos`
**Estructura**:
```sql
CREATE TABLE Periodos (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Descripcion VARCHAR(255) NOT NULL
);
```
**Explicación**: 
Los periodos, como "Período de punta", "Período intermedio", y "Período de Valle", definen diferentes intervalos del día donde las tarifas eléctricas pueden variar. Esta tabla permite flexibilidad ya que puedes agregar o eliminar períodos según sea necesario, haciendo el sistema escalable.

### 5. `Feriados`
**Estructura**:
```sql
CREATE TABLE Feriados (
    FeriadoId INT PRIMARY KEY AUTO_INCREMENT,
    PaisId INT,
    Descripcion VARCHAR(255) NOT NULL,
    FechaFeriado DATE NOT NULL,
    EsNacional BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (PaisId) REFERENCES Paises(PaisId)
);
```
**Explicación**: 
Los feriados son días específicos que pueden tener tarifas eléctricas particulares. Algunos feriados son nacionales y aplican a todas las regiones de un país, mientras que otros son específicos de una región. La opción `EsNacional` permite diferenciar entre estos casos.

### 6. `RangosHorarios`
**Estructura**:
```sql
CREATE TABLE RangosHorarios (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    PeriodoId INT,
    HoraInicio TIME NOT NULL,
    HoraFin TIME NOT NULL,
    FOREIGN KEY (PeriodoId) REFERENCES Periodos(Id)
);
```
**Explicación**: 
Esta tabla define los intervalos de tiempo exactos para cada periodo. Por ejemplo, el "Período de punta" podría ser de 08:00 a 10:00. Esta estructura permite tener múltiples rangos horarios para un solo periodo y cambiarlos según las necesidades.

### 7. `PreciosEnergiaPorHorario`
**Estructura**:
```sql
CREATE TABLE PreciosEnergiaPorHorario (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    ClaseDiaId INT,
    RangoHorarioId INT,
    RegionId INT,
    Precio DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ClaseDiaId) REFERENCES ClaseDia(Id),
    FOREIGN KEY (RangoHorarioId) REFERENCES RangosHorarios(Id),
    FOREIGN KEY (RegionId) REFERENCES Region(RegionId)
);
```
**Explicación**: 
La tabla es el corazón del sistema. Aquí se define el precio de la energía eléctrica según el tipo de día (`ClaseDiaId`), el rango horario (`RangoHorarioId`), y la región (`RegionId`). Esta estructura permite configurar precios específicos para cualquier combinación de esos factores.

**En cuanto a la normalización**:
Las tablas están en 3NF:

- 1FN: Cada tabla tiene un identificador único y valores atómicos.
- 2FN: Todas las columnas en cada tabla dependen completamente de su clave primaria.
- 3FN: No hay dependencias transitivas entre columnas no clave.

### Tarifas Eléctricas Particulares por Regiones:

La tabla `PreciosEnergiaPorHorario` efectivamente permite definir tarifas eléctricas específicas por región. La columna `RegionId` está diseñada para tal propósito. Cuando ingreses un nuevo precio, este puede ser específico para una región, un rango horario y un tipo de día.

Por ejemplo, si la región 1 (que podría ser "Norte") tiene un precio diferente para la energía eléctrica en un período de punta en un día laborable, simplemente insertarías un registro en `PreciosEnergiaPorHorario` con el `RegionId` correspondiente a "Norte", el `RangoHorarioId` que corresponde al período de punta y el `ClaseDiaId` que corresponde a "Laborable". El campo `Precio` reflejará el costo específico para esa combinación.

### Tarifas Eléctricas por Días Especiales:

Para manejar tarifas eléctricas por días especiales (como vacaciones o cualquier otro día que no sea un feriado nacional o regional regular), podrías hacerlo de varias maneras:

1. **Expandir la tabla `ClaseDia`**: Podrías agregar más tipos al ENUM, como 'Vacaciones', y luego definir tarifas específicas para ese tipo de día en `PreciosEnergiaPorHorario`.

2. **Tabla separada para Días Especiales**: 
```sql
CREATE TABLE DiasEspeciales (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    RegionId INT,
    Descripcion VARCHAR(255) NOT NULL,
    Fecha DATE NOT NULL,
    FOREIGN KEY (RegionId) REFERENCES Region(RegionId)
);
```
Con esta tabla, puedes registrar días especiales para regiones específicas. Luego, cuando determines los precios para un día en particular, consultarías si ese día está en `DiasEspeciales` para la región dada y aplicarías la tarifa adecuada.
