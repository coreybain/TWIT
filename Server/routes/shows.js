var express = require('express');
var router = express.Router();
var twitServerSync = require('../twit/twitServerSync');

//MARK: -- Variables
var showsDict = {}


/* GET home page. */
router.get('/', function(req, res, next) {

twitServerSync.twitConnect("shows", null, null, function(result) {
    
    var fs = require('fs'),
    request = require('request');

var download = function(uri, filename, callback){
  request.head(uri, function(err, res, body){
    console.log('content-type:', res.headers['content-type']);
    console.log('content-length:', res.headers['content-length']);

    request(uri).pipe(fs.createWriteStream(filename)).on('close', callback);
  });
};

          var shows = result['shows'];

          for (var show in shows) {

              if (shows[show] != null) {
                      // var heroUrl = shows[show]['heroImage']['url'];
                      //var heroUrl = shows[show]['heroImage']['derivatives']['thumbnail'];
                      // var heroFileName = shows[show]['heroImage']['fileName'];
                      // console.log(heroUrl);
                      // console.log(heroFileName);
                      // download(heroUrl, heroFileName, function(){
                      // console.log('Hero Image done');
                      // });
                      //var coverUrl = shows[show]['coverArt']['url'];
                      var coverUrl = shows[show]['coverArt']['derivatives']['twit_album_art_600x600'];
                      var coverFileName = shows[show]['coverArt']['fileName'];
                      console.log(coverUrl);
                      console.log(coverFileName);
                      download(coverUrl, coverFileName, function(){
                      console.log('Cover Image done');
                      });
                    }
                  }


      //res.send(result);
  })
});

module.exports = router;
