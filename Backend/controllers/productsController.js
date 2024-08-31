const Product = require("../models/Product");

module.exports = {
    createProduct: async (req, res) => {
        const newProduct = new Product(req.body);
        try {
            const productData = await newProduct.save();
            res.status(200).json(productData)
        } catch (error) {
            res.status(500).json({ response: "Failed To Create Product" })
        }
    },

    getAllProduct: async (req, res) => {
        try {
            const products = await Product.find().sort({createdAt:-1});
            res.status(200).json(products)
        } catch (error) {
            res.status(500).json({ response: "Failed To get Product" })
        }
    },

    getProduct: async (req, res) => {
        const productId=req.params.id;
        try {
            const product = await Product.findById(productId);
            const {__v,createdAt,...productData}= product._doc;
            res.status(200).json(productData)
        } catch (error) {
            res.status(500).json({ response: "Failed To get Product" })
        }
    },

    searchProduct : async (req, res) => {
        try {
          const result = await Product.aggregate([
            {
              $match: {
                $text: {
                  $search: req.params.key,
                  $caseSensitive: false, 
                  $diacriticSensitive: false 
                }
              }
            },
            {
              $sort: { score: { $meta: "textScore" } }
            }
          ]);
      
          res.status(200).json(result);
        } catch (error) {
          res.status(500).json({ error: error.message });
        }
    },
      
}