-- Active: 1723121637486@@127.0.0.1@3306@bbdd_restaurante

-- se debe crear la carpeta de Carga Masiva con los respectivos archivos .csv en la siguiente ruta: c:\xampp\mysql\data

USE BBDD_Restaurante

-- con este Script nos aseguramos de borrar los datos de las tablas en caso de que ya contengan registros

DELETE FROM Factura;
DELETE FROM Mesero;
DELETE FROM Cliente;
DELETE FROM Tipo_Producto;
DELETE FROM Categoria;
DELETE FROM Producto;
DELETE FROM Factura_Producto;

-- con este Script nos aseguramos de reiniciar el autoincrement en 0 para evitar inconvenientes con la nueva asignacion de ID

ALTER TABLE Factura AUTO_INCREMENT = 0;
ALTER TABLE Mesero AUTO_INCREMENT = 0;
ALTER TABLE Cliente AUTO_INCREMENT = 0;
ALTER TABLE Tipo_Producto AUTO_INCREMENT = 0;
ALTER TABLE Categoria AUTO_INCREMENT = 0;
ALTER TABLE Producto AUTO_INCREMENT = 0;
ALTER TABLE Factura_Producto AUTO_INCREMENT = 0;

-- carga masiva de la tabla Mesero

LOAD DATA INFILE 'Carga Masiva/Mesero.csv'
REPLACE INTO TABLE Mesero 
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Mes_Nombre);

-- carga masiva de la tabla Cliente

LOAD DATA INFILE 'Carga Masiva/Cliente.csv'
REPLACE INTO TABLE Cliente
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Cli_TipoCliente);

-- carga masiva de la tabla Tipo_Producto

LOAD DATA INFILE 'Carga Masiva/Tipo_Producto.csv'
REPLACE INTO TABLE Tipo_Producto
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(TiP_NombrePro);

-- carga masiva de la tabla Categoria

LOAD DATA INFILE 'Carga Masiva/Categoria.csv'
REPLACE INTO TABLE Categoria
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Cat_NombreCategoria);

-- carga masiva de la tabla Factura

LOAD DATA INFILE 'Carga Masiva/Factura.csv'
REPLACE INTO TABLE Factura
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Fac_Orden, Fac_Fecha, Fac_HoraCobro, Fac_Mesa, Fac_Propina, FK_Id_Mesero, FK_Id_Cliente);

-- carga masiva de la tabla Producto

LOAD DATA INFILE 'Carga Masiva/Producto.csv'
REPLACE INTO TABLE Producto
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Pro_Nombre, Pro_Precio, Pro_Costo, FK_Id_Categoria, FK_Id_TipoProducto);

-- carga masiva de la tabla Factura_Producto

LOAD DATA INFILE 'Carga Masiva/Factura_Producto.csv'
REPLACE INTO TABLE Factura_Producto
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(FK_Id_Factura, FK_Id_Producto);


SELECT  
    Factura.Fac_Orden AS Orden,
    Factura.Fac_Mesa AS Mesa, 
    Mesero.Mes_Nombre AS Mesero, 
    Producto.Pro_Nombre AS Producto
FROM 
    Factura
INNER JOIN Mesero ON Factura.FK_Id_Mesero = Mesero.Id_Mesero  
INNER JOIN Factura_Producto ON Factura.Id_Factura = Factura_Producto.FK_Id_Factura
INNER JOIN Producto ON Factura_Producto.FK_Id_Producto = Producto.Id_Producto
WHERE Factura_Producto.FK_Id_Factura = 1;
