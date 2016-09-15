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

            var mainDict = {
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
              };

            if (shows[show]['video_audio'] != null) {
                mainDict["video_audio"] = {
                    mediaUrl: shows[show]['video_audio']['mediaUrl'],
                    format: shows[show]['video_audio']['format'],
                    changed: shows[show]['video_audio']['changed'],
                    runningTime: shows[show]['video_audio']['runningTime'],
                    hours: shows[show]['video_audio']['hours'],
                    minutes: shows[show]['video_audio']['minutes'],
                    seconds: shows[show]['video_audio']['seconds'],
                    size: shows[show]['video_audio']['size']
                };
            };

            if (shows[show]['video_hd'] != null) {
                mainDict["video_hd"] = {
                    mediaUrl: shows[show]['video_hd']['mediaUrl'],
                    format: shows[show]['video_hd']['format'],
                    changed: shows[show]['video_hd']['changed'],
                    runningTime: shows[show]['video_hd']['runningTime'],
                    hours: shows[show]['video_hd']['hours'],
                    minutes: shows[show]['video_hd']['minutes'],
                    seconds: shows[show]['video_hd']['seconds'],
                    size: shows[show]['video_hd']['size']
                };
            };

            if (shows[show]['video_large'] != null) {
                mainDict["video_large"] = {
                  mediaUrl: shows[show]['video_large']['mediaUrl'],
                  format: shows[show]['video_large']['format'],
                  changed: shows[show]['video_large']['changed'],
                  runningTime: shows[show]['video_large']['runningTime'],
                  hours: shows[show]['video_large']['hours'],
                  minutes: shows[show]['video_large']['minutes'],
                  seconds: shows[show]['video_large']['seconds'],
                  size: shows[show]['video_large']['size']
                };
            };

            if (shows[show]['video_small'] != null) {
                mainDict["video_large"] = {
                  mediaUrl: shows[show]['video_small']['mediaUrl'],
                  format: shows[show]['video_small']['format'],
                  changed: shows[show]['video_small']['changed'],
                  runningTime: shows[show]['video_small']['runningTime'],
                  hours: shows[show]['video_small']['hours'],
                  minutes: shows[show]['video_small']['minutes'],
                  seconds: shows[show]['video_small']['seconds'],
                  size: shows[show]['video_small']['size']
                };
            };

            if (shows[show]['video_youtube'] != null) {
                mainDict["video_large"] = {
                video_youtube: shows[show]['video_youtube']
              };
            };

              episodesRef.child(showNumber).child(shows[show]['id']).set(mainDict);
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