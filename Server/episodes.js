var express = require('express');
var router = express.Router();
var firebase = require("firebase");

firebase.initializeApp({
  databaseURL: "https://twit-mobile.firebaseio.com/",
  serviceAccount: "./TWIT-MOBILE-febd239fd2d6.json"
});

//MARK: -- Variables
var showsDict = {}
var db = firebase.database();
var ref = db.ref("categories");
var episodesRef = db.ref("episodes");
var serverCount = 0
var twitCount = 0

/* GET home page. */
router.get('/', function(req, res, next) {

  var request = require('request');

  var options = {
    url: 'https://twit.tv/api/v1.0/episodes',
    headers: {
      'Accept': 'application/json',
      'app-id': '3e742ac7',
      'app-key': '2a6557daace8c6524cc82af2e718fbcc'
    }
  };

  function callback(error, response, body) {
    if (!error && response.statusCode == 200) {
      var respons = JSON.parse(body);
      var shows = respons['episodes'];

      twitCount = respons['count'];
      res.send(respons);

      episodesRef.child('count').on("value", function(snapshot) {
        if (snapshot.exists()) {
          serverCount = snapshot.val().count
            console.log('there it is -- it exists')
        } else {
          serverCount = 0
            console.log('didnt exist')
        }
        if (respons['count'] > serverCount) {
          console.log('IT IS BIGGER')
          episodesRef.child('count').set({
            count: respons['count']
          });
          for (var show in shows) {
              episodesRef.child(shows[show]['id']).set({

                id: shows[show]['id'],
                label: shows[show]['label'],
                showNotes: shows[show]['showNotes'],
                cleanPath: shows[show]['cleanPath'],
                episodeNumber: shows[show]['episodeNumber'],
                teaser: shows[show]['teaser'],
                airingDate: shows[show]['airingDate'],
                featured: shows[show]['featured'],
                showNotesFooter: shows[show]['showNotesFooter'],
                created: shows[show]['created'],
                changed: shows[show]['changed']
              });
          };
        } else {
          console.log('IT IS the same or smaller')
        }
      }, function (errorObject) {
        console.log("The read failed: " + errorObject.code);
      });

    } else {
      res.send(response.statusCode);
    }
  };


  request(options, callback);
});

module.exports = router;
