const express=require('express')
const bodyParser=require('body-parser')
const mysql2=require('mysql2/promise')
const path = require('path'); 

const app=express()

app.use(bodyParser.urlencoded({extended:true})) //leer url
app.use(bodyParser.json()) //converit los datos en json

app.use(express.static(path.join(__dirname, 'Public')));

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'Public/pagina/index.html'));
});

const db=mysql2.createPool({
    host:'localhost',
    user:'root',
    password:'',
    database:'BBDD_Restaurante'
})

  app.post('/insertar_F',async(req,res)=>{

    const {Fac_Orden,Fac_Mesa,FK_Id_Mesero,Pro_Nombre}=req.body

    try{
    const [rows]=await db.query('INSERT INTO Factura (Fac_Orden,Fac_Mesa,FK_Id_Mesero) VALUES (?,?,?)',[Fac_Orden,Fac_Mesa,FK_Id_Mesero])

    //Enviar los productos como un array para que se detecten como una lista
    if (Array.isArray(Pro_Nombre)) {
        for (const producto of Pro_Nombre) {
            if (producto.trim()) { // Evitar productos vacíos
                await db.query('INSERT INTO Producto (Pro_Nombre) VALUES (?)', [producto]);
            }
        }
    }



    console.log(rows)
     res.redirect('/pagina/index.html'); 
    
    }
    catch(error)
    {
        console.error('El error empieza aqui ',error)

    }
})  




app.listen(3000,()=>{
    console.log('servidor activo')
})