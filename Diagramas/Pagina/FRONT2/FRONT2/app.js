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
app.post('/insertar',async(req,res)=>{
    const {Fac_Orden, Fac_Fecha, Fac_HoraCobro, Fac_Mesa, Fac_Propina,FK_Id_Mesero, FK_Id_Cliente}=req.body

    try{
    const [rows]=await db.query('INSERT INTO Factura (Fac_Orden, Fac_Fecha, Fac_HoraCobro, Fac_Mesa, Fac_Propina, FK_Id_Mesero, FK_Id_Cliente) VALUES (?,?,?,?,?,?,?)',[Fac_Orden, Fac_Fecha, Fac_HoraCobro, Fac_Mesa, Fac_Propina, FK_Id_Mesero, FK_Id_Cliente])

    console.log(rows)
    /*  res.send('Mi perro se insertaron los datos')  */
     res.redirect('/pagina/Pedidos.html'); 
    
    }
    catch(error)
    {
        console.error('El error empieza aqui ',error)
    }
})

/* app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'pagina/index.html'));
  }); 
  
  Public/pagina/index.html
  */

app.listen(3000,()=>{
    console.log('servidor activo')
})