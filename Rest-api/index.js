// DEPENDENCIES
const express = require('express');
const cors = require("cors");
const bodyParser = require("body-parser");
const router = require("./routers/main.js");
const validator = require('./routers/validator.js');
const memeLogic = require("./logic/meme.js");

// CONSTANTS
const port = process.env.PORT || 8080;

// SETUP
var app = express();

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
  extended: true
}));
app.use(validator);
app.use("/", router);

// START SERVER
app.listen(port, function() {
  console.log("Server listening on port: " + port);
});

// REALTIME JOBS
memeLogic.notifyNewMeme();
