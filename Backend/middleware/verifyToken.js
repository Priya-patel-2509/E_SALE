const jwt = require("jsonwebtoken");
const User = require("../models/User");

const verifyToken = (req, res, next) => {
    const authHeader = req.headers.token;

    if (authHeader) {
        const token = authHeader.split(" ")[1];
        jwt.verify(token, process.env.JWT_SECRET, async (error, user) => {
            if (error) {
                return res.status(403).json({ response: error.message });
            }
            req.user = user;
            next();
        });
    } else {
        return res.status(401).json({ response: "You Are Not Authenticated" });
    }
};

module.exports = { verifyToken };