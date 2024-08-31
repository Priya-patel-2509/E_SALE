const mongoose = require("mongoose");

const ConfirmOrderSchema = new mongoose.Schema({

    userId: { type: String, required: true },
    image:{type:String},
    name:{type:String},
    productId: {type:String,},
    quantity: { type: Number, required: true },
    delivery_status: { type: String, required: true, default: "pending" },
    payment_status: { type: String, required: true },
    total: { type: String, required: true },

}, { timestamps: true })

module.exports = mongoose.model("ConfirmOrder", ConfirmOrderSchema);