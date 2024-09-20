const express = require('express')
const bodyParser = require('body-parser')
const mysql2 = require('mysql2/promise')
const path = require('path');

const app = express()

app.use(bodyParser.urlencoded({ extended: true })) //leer url
app.use(bodyParser.json()) //converit los datos en json

app.use(express.static(path.join(__dirname, 'Public')));

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'Public/pagina/index.html'));
});

const db = mysql2.createPool({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'BBDD_Restaurante'
})

app.post('/insertar_F', async (req, res) => {

    const { Fac_Orden, Fac_Mesa, FK_Id_Mesero, Pro_Nombre } = req.body

    try 
    {
        const [facturaRows] = await db.query('INSERT INTO Factura (Fac_Orden,Fac_Mesa,FK_Id_Mesero) VALUES (?,?,?)', [Fac_Orden, Fac_Mesa, FK_Id_Mesero])

        const ordenID = facturaRows.insertId;
        //Enviar el Id de la nueva factura


        //Enviar los productos como un array para que se detecten como una lista

        if (Array.isArray(Pro_Nombre)) {
            for (const producto of Pro_Nombre) {
                if (producto.trim()) {
                    // Evitar productos vacíos
                    const [productoResult] = await db.query(
                        'INSERT INTO Producto (Pro_Nombre) VALUES (?) ON DUPLICATE KEY UPDATE Id_Producto=LAST_INSERT_ID(Id_Producto)',
                        [producto]);

                    const productoID = productoResult.insertId;  // ID del producto recién insertado

                    // Insertar en la tabla intermedia Factura_Producto 
                    await db.query(
                        'INSERT INTO Factura_Producto (FK_Id_Factura, FK_Id_Producto) VALUES (?, ?)',
                        [ordenID, productoID]
                    );
                }
            }
        }







        console.log(facturaRows)

        res.json({
            Numerodepedido: ordenID
        }).redirect('/pagina/index.html');


    }
    catch (error) {
        console.error('El error empieza aqui', error)

    }
})




app.listen(3000, () => {
    console.log('servidor activo')
})
