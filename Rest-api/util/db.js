// DEPENDENCIES
const ref = require("./firebase.js").database().ref();

// CONSTANTS
const errNoExist = "Object with id does not exist";
const refs = {
  userRef: ref.child("Users"),
  memeRef: ref.child("Memes")
};

// HELPERS
function _setLastUpdated(fieldToVal) {
  fieldToVal.lastUpdated = new Date().getTime() / 1000;
}

function _singleCallback(snapshot) {
  if (!snapshot.exists()) return null;
  var obj = snapshot.val();
  obj._key = snapshot.key;
  return obj;
}

function _multipleCallback(snapshot) {
  if (!snapshot.exists()) return [];
  var result = [];
  snapshot.forEach(function(childSnapshot) {
    result.push(_singleCallback(childSnapshot));
  });
  return result;
}

function _create(ref, fieldToVal) {
  _setLastUpdated(fieldToVal);
  return ref.set(fieldToVal).then(function() {
    return getById(ref, childRef.key);
  });
}

// METHODS
function getAll(ref) {
  return ref.once("value").then(_multipleCallback);
}

function getById(ref, id) {
  return ref.child(id).once("value").then(function(snapshot) {
    if (!snapshot.exists()) return Promise.reject(new Error(errNoExist));
  });
}

function createByAutoId(ref, fieldToVal) {
  var childRef = ref.push();
  return _create(childRef, fieldToVal);
}

function createByManualId(ref, id, fieldToVal) {
  var childRef = ref.child(id);
  return _create(childRef, fieldToVal);
}

function updateById(ref, id, fieldToVal) {
  _setLastUpdated(fieldToVal);
  return ref.child(id).update(fieldToVal).then(function() {
    return getById(ref, id);
  });
}

function transaction(ref, id, field, atomicFn) {
  return ref.child(id).child(field).transaction(atomicFn, true);
}

function listenForChanges(ref, emitCb) {
  return ref.on("child_added", function(snapshot) {
    var obj = _singleCallback(snapshot);
    emitCb(obj);
  });
}

// EXPORTS
module.exports.getAll = getAll;
module.exports.getById = getById;
module.exports.createByAutoId = createByAutoId;
module.exports.createByManualId = createByManualId;
module.exports.refs = refs;
module.exports.updateById = updateById;
module.exports.transaction = transaction;
module.exports.listenForChanges = listenForChanges;
