const User = require("../models/User");

const CryptoJS = require("crypto-js");
const jwt = require("jsonwebtoken");

module.exports={
    createUser :async(req,res)=>{

        const newUser = new User({
            username:req.body.username,
            email:req.body.email,
            password:CryptoJS.AES.encrypt(req.body.password,process.env.SECRET).toString(),
            location:req.body.location
        })
        try {
            userData = await newUser.save();
            res.status(201).json(userData)

        } catch (error) {
            res.status(500).json({message:error.message.toString()})
        }
    },
    
    loginUser :async(req,res)=>{
       try{ 
            const user = await User.findOne({email:req.body.email})
            !user && res.status(401).json({message:"Could not find user"});

            const decryptPass = CryptoJS.AES.decrypt(user.password,process.env.SECRET);
            const thePassword = decryptPass.toString(CryptoJS.enc.Utf8);

            thePassword !== req.body.password && res.status(401).json({message:"Password is Wrong"});

            const userToken = jwt.sign({
                id:user._id
            },process.env.JWT_SECRET,{expiresIn:"21d"});

            const {password,__v,updatedAt,createdAt,...others} = user._doc;
            res.status(200).json({...others,token:userToken})
        }catch(error){
            res.status(401).json({message:"Please Check Your Credentials"});
        }
    }
}