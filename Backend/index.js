const express = require("express");
const app=express();
const dotenv= require("dotenv");
const database=require("./database/db_conn");
const productRoute = require("./routes/productRoutes");
const authRoute = require("./routes/authRoutes");
const userRoute = require("./routes/userRoutes");
const orderRoute = require("./routes/orderRoutes");
const cartRoute = require("./routes/cartRoutes");
const port= process.env.PORT|| 3000;
dotenv.config();


app.use(express.json({limit:'10mb'}));
app.use(express.urlencoded({limit:'10mb',extended:true}));

app.use("/api/",authRoute);
app.use("/api/products/",productRoute);
app.use("/api/orders",orderRoute);
app.use("/api/cart",cartRoute);
app.use("/api/users/",userRoute);

app.get("/",(req,res)=>{
    res.send("Hello");
})

app.listen(port,()=>{
    console.log(`Listening port no ${port}`);
})