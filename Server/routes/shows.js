var express = require('express');
var router = express.Router();
var twitServerSync = require('../twit/twitServerSync');

//MARK: -- Variables
var showsDict = {}


/* GET home page. */
router.get('/', function(req, res, next) {

twitServerSync.twitConnect("shows", 1653, null, function(result) {
      /*
    // console.log(result['episodes']);
      if (result['episodes'] == "") {
        showNumber++;
        pageNumber = 1;
        console.log('Show has finished downloading all episodes');
      } else {
        firebaseServerSync.firebaseEpisodeSync("episodes", showID, result);
        if (active == true) {
          showNumber++;
          pageNumber = 1;
        console.log('Show has been updated');
        }
      }
      */
      res.send(result);
  })
});

module.exports = router;
