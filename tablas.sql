CREATE DATABASE HorariosJS;
USE HorariosJS;

CREATE TABLE Paises (
    PaisId INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Region (
    RegionId INT PRIMARY KEY AUTO_INCREMENT,
    PaisId INT,
    Nombre VARCHAR(100) NOT NULL,
    FOREIGN KEY (PaisId) REFERENCES Paises(PaisId)
);

CREATE TABLE ClaseDia (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Tipo ENUM('Laborable', 'Sábado', 'Domingo', 'Feriado') NOT NULL
);

CREATE TABLE Periodos (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    Descripcion VARCHAR(255) NOT NULL
);

CREATE TABLE Feriados (
    FeriadoId INT PRIMARY KEY AUTO_INCREMENT,
    PaisId INT,
    Descripcion VARCHAR(255) NOT NULL,
    FechaFeriado DATE NOT NULL,
    EsNacional BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (PaisId) REFERENCES Paises(PaisId)
);

CREATE TABLE RangosHorarios (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    PeriodoId INT,
    HoraInicio TIME NOT NULL,
    HoraFin TIME NOT NULL,
    FOREIGN KEY (PeriodoId) REFERENCES Periodos(Id)
);

CREATE TABLE DiasEspeciales (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    RegionId INT,
    Descripcion VARCHAR(255) NOT NULL,
    Fecha DATE NOT NULL,
    FOREIGN KEY (RegionId) REFERENCES Region(RegionId)
);

CREATE TABLE PreciosEnergiaPorHorario (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    ClaseDiaId INT NULL,
    RangoHorarioId INT,  
    RegionId INT,
    DiasEspecialesId INT NULL,
    FeriadoId INT NULL,
    Precio DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ClaseDiaId) REFERENCES ClaseDia(Id),
    FOREIGN KEY (RangoHorarioId) REFERENCES RangosHorarios(Id),
    FOREIGN KEY (RegionId) REFERENCES Region(RegionId),
    FOREIGN KEY (DiasEspecialesId) REFERENCES DiasEspeciales(Id), -- Y aquí la clave foránea
    CONSTRAINT FK_FeriadoId FOREIGN KEY (FeriadoId) REFERENCES Feriados(FeriadoId);
);


