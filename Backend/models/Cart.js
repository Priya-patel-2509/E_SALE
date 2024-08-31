const mongoose = require("mongoose");
const Product = require("../models/Product")

const CartSchema = new mongoose.Schema({

    userId:{
        type:String,
        required:true,
    },
    products:[
        {
            cartItem:{
                type:mongoose.Schema.Types.ObjectId,
                ref:Product,
            },
            quantity:{
                type:Number,
                default:1,
            }
        }
    ]
    
},{timestamps : true})

module.exports = mongoose.model("Cart",CartSchema);