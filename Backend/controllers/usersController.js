const User = require("../models/User");

module.exports={

    getUser : async(req,res)=>{
        try {
            const user = await User.findById(req.user.id);

            const {password,__v,updatedAt,createdAt,...userData} = user._doc;
            res.status(200).json(userData)
            
        } catch (error) {
            res.status(400).json({response:"NO Data Found!"})
        }
    },

    deleteUser :async(req,res)=>{
        try {
            await User.findByIdAndDelete(req.user.id);
            res.status(200).json({response:"User Data Deleted Succesfully"})
            
        } catch (error) {
            res.status(400).json({response:error.message.toString()})
        }
    }
}