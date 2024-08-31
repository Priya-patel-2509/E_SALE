const router = require("express").Router();
const cartController = require("../controllers/cartsController");
const {verifyToken} = require("../middleware/verifyToken")

router.get('/find/',verifyToken,cartController.getCart);
router.post('/',verifyToken,cartController.addCart);
router.delete('/:cartItem',verifyToken,cartController.deleteCart);

module.exports = router;