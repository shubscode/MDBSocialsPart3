// DEPENDENCIES
const fcm = require("./firebase.js").messaging();

// METHODS
function sendNotification(topic, message) {
  var options = {
    priority: "high"
  };

  var payload = {
    notification: {
      title: "MDBMemes",
      body: message,
      icon: "icon_notification",
      sound: "default"
    }
  };

  return fcm.sendToTopic(topic, payload, options);
}

// EXPORTS
module.exports.sendNotification = sendNotification;
