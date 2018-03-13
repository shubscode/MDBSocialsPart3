// DEPENDENCIES
const router = require("express").Router();
const completeRequest = require("../util/routing.js").completeRequest;
const memeLogic = require("../logic/meme.js");
const userRef = require("../logic/user.js").ref;

// ROUTES
router.get("/memes", function(req, res) {
  completeRequest(req, res, memeLogic.getAll);
});

router.get("/memes/:id", function(req, res) {
  req.checkParams("id", "no id present").notEmpty();
  req.checkParams("id", "meme id does not exist").isValidId(memeLogic.ref);
  completeRequest(req, res, function(params) {
    return memeLogic.getById(params.id);
  });
});

router.post("/memes", function(req, res) {
  req.checkBody("imageUrl", "no imageUrl passed").notEmpty();
  req.checkBody("imageUrl", "imageUrl is not a url").isValidUrl();
  req.checkBody("posterId", "no posterId passed").notEmpty();
  req.checkBody("posterId", "posterId does not exist").isValidId(userRef);
  completeRequest(req, res, memeLogic.createByAutoId);
});

// EXPORTS
module.exports = router;
