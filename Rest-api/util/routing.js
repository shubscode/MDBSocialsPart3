// HELPERS
function _getParamsByField(req, result, field) {
  //var result = {};
  for (var key in req[field]) {
    if (req[field][key] != null) {
      result[key] = req[field][key];
    }
  }
  return result;
}

function _aggregateParams(req) {
  var result = {};
  result = _getParamsByField(req, "query");
  result = _getParamsByField(req, "body");
  result = _getParamsByField(req, "params");
  return result;
}

// METHODS
function completeRequest(req, res, func) {
  return req.getValidationResult().then(function(result) {
    if (!result.isEmpty()) {
      res.status(400).json(result.array());
      return;
    }
    var allParams = _aggregateParams(req);
    return func(allParams).then(function(result) {
      res.status(200).json(result);
    }).catch(function(error) {
      res.status(500).send(error.toString());
    });
  });
}

function rejectRequest(req, res) {
  return completeRequest(req, res, function(params) {
    return Promise.reject(new Error("Could not clasify your request."));
  });
}

// EXPORTS
module.exports.completeRequest = completeRequest;
module.exports.rejectRequest = rejectRequest;
