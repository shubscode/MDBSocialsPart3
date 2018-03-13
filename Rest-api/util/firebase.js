// DEPENDENCIES
const firebase = require("firebase-admin");

// INITIALIZE
var serviceAccount = require('../mdb-socials-de8ac-firebase-adminsdk-nz3e7-51363d3c3c');

firebase.initializeApp({
  credential: firebase.credential.cert(serviceAccount),
  databaseURL: 'https://mdb-socials-de8ac.firebaseio.com'
});

// EXPORTS
module.exports = firebase;
