var firebase = require("firebase");

firebase.initializeApp({
  databaseURL: "https://twit-mobile.firebaseio.com/",
  serviceAccount: "./TWIT-MOBILE-febd239fd2d6.json"
});

//Global variables
var db = firebase.database();
var episodesRef = db.ref("episodes");
var serverCount = 0
var twitCount = 0

function firebaseEpisodeSync(dbRef, showNumber, data) {
      var shows = data['episodes'];
    episodesRef.child('count').on("value", function(snapshot) {
        /*
        if (snapshot.exists()) {
          serverCount = snapshot.val().count
            console.log('there it is -- it exists')
        } else {
          serverCount = 0
            console.log('didnt exist')
        } 
        if (data['count'] > serverCount) {
          console.log('IT IS BIGGER')
          episodesRef.child('count').set({
            count: data['count']
          });*/
          for (var show in shows) {
              episodesRef.child(showNumber).child(shows[show]['id']).set({

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
                console.log('WORKING...');
          };
          console.log('COMPLETE');
       /* } else {
          console.log('IT IS the same or smaller')
        } */
      }, function (errorObject) {
        console.log("The read failed: " + errorObject.code);
      });
}
module.exports.firebaseEpisodeSync = firebaseEpisodeSync;