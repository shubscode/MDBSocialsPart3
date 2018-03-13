// DEPENDENCIES
const expressValidator = require('express-validator');
const isUrl = require('is-url');
const fs = require("fs");
const getById = require("../util/db.js").getById;

// EXPORTS
module.exports = expressValidator({
  customValidators: {
    isValidId: function(param, ref) {
      return getById(ref, param).then(function() {
        return true;
      }).catch(function() {
        return false;
      });
    },
    isValidDate: function(param) {
      if (!param || typeof(param) != "string" ||
        param.trim() == "" || param.indexOf("-") < 0)
        return false;
      var x = param.split("-");
      if (x.length != 3) return false;
      if (x[0].length > 2 || x[0].length == 0) return false;
      if (x[1].length > 2 || x[1].length == 0) return false;
      if (x[2].length != 4) return false;
      var isValidNumber = function(param) {
        var num = +param;
        return !isNaN(num);
      }
      return isValidNumber(x[0]) && isValidNumber(x[1]) &&
        isValidNumber(x[2]);
    },
    isValidBool: function(param) {
      return param == "true" || param == "false" ||
        param === true || param === false;
    },
    isValidFile: function(param) {
      return param && param.path && fs.existsSync(param.path);
    },
    valueLessThan: function(param, value) {
      return param < value;
    },
    valueGreaterThan: function(param, value) {
      return param > value;
    },
    isNonEmptyArray: function(value) {
      return (Array.isArray(value)) && (value.length > 0);
    },
    isTrue: function(param) {
      return param == "true";
    },
    isValidNumber: function(param) {
      var num = +param;
      return !isNaN(num);
    },
    isValidNumberArr: function(param) {
      var isValidNumber = function(param) {
        var num = +param;
        return !isNaN(num);
      }
      if (!Array.isArray(param) || param.length == 0) return false;
      for (var i = 0; i < param.length; i++) {
        var value = param[i];
        if (!isValidNumber(value)) return false;
        param[i] = parseFloat(param[i]);
      }
      return true;
    },
    isValidUrl: function(param) {
      return isUrl(param);
    }
  }
});
