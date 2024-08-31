const ConfirmOrder = require("../models/confirmOrder");

module.exports={

    postUserOrders:async (req,res)=>{

        const newOrder = new ConfirmOrder(req.body);
        try {
            const userOrder= await newOrder.save();
            res.status(200).json(userOrder);
        } catch (error) {
            res.status(400).json(error)
        }
    },

    getUserOrders : async (req,res)=>{

        const userId = req.user.id;
        try {
            const userOrders = await ConfirmOrder.find({userId})
            .populate({
                path:"productId",
                select:"-sizes -oldPrice -discription -category"
            }).exec();

            res.status(200).json(userOrders);
        } catch (error) {
            res.status(500).json({response:"Failed To Get Order"})
        }
    }
}