const router = require("express").Router();
const ConfirmOrderController = require("../controllers/confirmOrderController")
const {verifyToken} = require("../middleware/verifyToken")

router.post('/',verifyToken,ConfirmOrderController.postUserOrders);
router.get('/',verifyToken,ConfirmOrderController.getUserOrders);

module.exports = router;