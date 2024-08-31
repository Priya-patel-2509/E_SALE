const mongoose = require("mongoose");
const dotenv= require("dotenv");
dotenv.config();

const mongoUrl = process.env.MONGODB_URL_LOCAL;

const connection = mongoose.connect(mongoUrl).then(()=>{console.log("Database Connected");}).catch((error)=>{console.error(error);})

module.exports = connection;