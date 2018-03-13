// DEPENDENCIES
const db = require("../util/db.js");
const fcm = require("../util/fcm.js");

// REF
const ref = db.refs.memeRef;
const topic = "new-meme";
const newMemeMsg = "A new meme has been added";

// METHODS
function getAll() {
  return db.getAll(ref);
}

function getById(id) {
  return db.getById(ref, id);
}

function createByAutoId(fieldToVal) {
  return db.createByAutoId(ref, {
    imageUrl: fieldToVal.imageUrl,
    posterId: fieldToVal.posterId
  });
}

function notifyNewMeme() {
  db.listenForChanges(ref, function(meme) {
    fcm.sendNotification(topic, newMemeMsg);
  });
}

// EXPORTS
module.exports.getAll = getAll;
module.exports.getById = getById;
module.exports.createByAutoId = createByAutoId;
module.exports.notifyNewMeme = notifyNewMeme;
module.exports.ref = ref;
