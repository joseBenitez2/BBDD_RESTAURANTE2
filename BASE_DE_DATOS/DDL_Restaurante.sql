-- Active: 1723121637486@@127.0.0.1@3306
CREATE DATABASE BBDD_Restaurante
    DEFAULT CHARACTER SET = 'utf8mb4';
    USE BBDD_Restaurante;
-- Creacion de tabla Mesero
    CREATE TABLE Mesero (
    Id_Mesero INT AUTO_INCREMENT PRIMARY KEY,
    Mes_Nombre VARCHAR (20)
);

-- Creacion de tabla Cliente

CREATE TABLE Cliente (
    Id_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Cli_TipoCliente VARCHAR (30)
);

-- Creacion de tabla Tipo_Producto

CREATE TABLE Tipo_Producto (
    Id_TipoProducto INT AUTO_INCREMENT PRIMARY KEY,
    TiP_NombrePro VARCHAR (20)
);

-- Creacion de tabla Categoria

CREATE TABLE Categoria (
    Id_Categoria INT AUTO_INCREMENT PRIMARY KEY,
    Cat_NombreCategoria VARCHAR (20)
);

-- Creacion de tabla Fatura con sus relaciones

CREATE TABLE Factura (
    Id_Factura INT AUTO_INCREMENT PRIMARY KEY,
    Fac_Orden INT (5),
    Fac_Fecha DATE,
    Fac_HoraCobro TIME,
    Fac_Mesa INT (5),
    Fac_Propina DECIMAL (10),
    FK_Id_Mesero INT NOT NULL,
    FK_Id_Cliente INT NOT NULL,
    FOREIGN KEY (FK_Id_Mesero) REFERENCES Mesero (Id_Mesero),
    FOREIGN KEY (FK_Id_Cliente) REFERENCES Cliente (Id_Cliente)
);

-- Creacion de tabla Producto con sus relaciones

CREATE TABLE Producto (
    Id_Producto INT AUTO_INCREMENT PRIMARY KEY,
    Pro_Nombre VARCHAR (50),
    Pro_Precio DECIMAL (5, 2),
    Pro_Costo DECIMAL (5, 2),
    FK_Id_Categoria INT (10),
    FK_Id_TipoProducto INT (10),
    FOREIGN KEY (FK_Id_Categoria) REFERENCES Categoria (Id_Categoria),
    FOREIGN KEY (FK_Id_TipoProducto) REFERENCES Tipo_Producto (Id_TipoProducto)
);

-- Creacion de tabla intermedia Factura_Producto con sus relaciones

CREATE TABLE Factura_Producto (
    FK_Id_Factura INT NOT NULL,
    FK_Id_Producto INT NOT NULL,
    FOREIGN KEY (FK_Id_Factura) REFERENCES Factura (Id_Factura),
    FOREIGN KEY (FK_Id_Producto) REFERENCES Producto (Id_Producto)
);
