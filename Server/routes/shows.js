var express = require('express');
var router = express.Router();

//MARK: -- Variables
var showsDict = {}


/* GET home page. */
router.get('/', function(req, res, next) {

  var request = require('request');

  var options = {
    url: 'https://twit.tv/api/v1.0/shows',
    headers: {
      'Accept': 'application/json',
      'app-id': '3e742ac7',
      'app-key': '2a6557daace8c6524cc82af2e718fbcc'
    }
  };

  function callback(error, response, body) {
    if (!error && response.statusCode == 200) {
      var respons = JSON.parse(body)
      showsDict.count = respons['count']
      res.send(respons);
      console.log(respons['count'])
    } else {
      res.send(response.statusCode)
    }
  }

  request(options, callback);
});

module.exports = router;
