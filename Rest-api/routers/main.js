// DEPENDENCIES
const router = require("express").Router();
const userRouter = require("./user.js");
const memeRouter = require("./meme.js");

// ROUTES
router.use(userRouter);
router.use(memeRouter);

// EXPORTS
module.exports = router;
