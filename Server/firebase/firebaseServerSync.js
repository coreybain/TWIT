var firebase = require("firebase");

firebase.initializeApp({
  databaseURL: "https://twit-mobile.firebaseio.com/",
  serviceAccount: "./TWIT-MOBILE-febd239fd2d6.json"
});

//Global variables
var db = firebase.database();
var episodesRef = db.ref("episodes");
var showRef = db.ref("Shows");
var activeShowRef = db.ref("activeShows");
var peopleRef = db.ref("people");
var castRef = db.ref("cast");
var rolesRef = db.ref("roles");
var offersRef = db.ref("offers");
var categoriesRef = db.ref("categories");
var categoryEpisodesRef = db.ref("categoryEpisodes");
var serverCount = 0
var twitCount = 0

function deletefirebase() {
  db.ref("categories").remove();
  db.ref("episodes").remove();
  db.ref("fufufu").remove();
  db.ref("shows").remove();
  db.ref("test").remove();
}

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

            var showDict = {}
            var peopleDict = {}
            var rolesDict = {}
            var offersDict = {}
            var categoriesDict = {}
            var peopleArray = [];
            var offersArray = [];
            var categoriesArray = [];
            var catNewsDict = {};
            var catHelpHowDict = {};
            var catReviewsDict = {};
            var peopleID = 0;
            var showsID = 0;
            var offerID = 0;
            var rolesID = 0;
            var categoriesID = 0;

            var mainDict = {
                id: shows[show]['id'],
                label: shows[show]['label'],
                showNotes: shows[show]['showNotes'],
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
                mainDict["video_small"] = {
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

            if (shows[show]['_embedded'] != null) {
              mainDict['embedded'] = {}
                for (var credit in shows[show]['_embedded']['credits']) {
                  mainDict['embedded']['credits'] = {
                    [shows[show]['_embedded']['credits'][credit]['id']]: {
                      id: shows[show]['_embedded']['credits'][credit]['id'],
                      label: shows[show]['_embedded']['credits'][credit]['label'],
                      ttl: shows[show]['_embedded']['credits'][credit]['ttl'],
                      created: shows[show]['_embedded']['credits'][credit]['created']
                    }
                  }
                  if (shows[show]['_embedded']['credits'][credit]['roles'] != null) {
                    mainDict['embedded']['credits'][shows[show]['_embedded']['credits'][credit]['id']]['roles'] = {
                      id: shows[show]['_embedded']['credits'][credit]['roles']['id'],
                      label: shows[show]['_embedded']['credits'][credit]['roles']['label'],
                      ttl: shows[show]['_embedded']['credits'][credit]['roles']['ttl'],
                      weight: shows[show]['_embedded']['credits'][credit]['roles']['weight'],
                      vid: shows[show]['_embedded']['credits'][credit]['roles']['vid'],
                      type: shows[show]['_embedded']['credits'][credit]['roles']['type'],
                      vocabularyName: shows[show]['_embedded']['credits'][credit]['roles']['vocabularyName'],
                      termPath: shows[show]['_embedded']['credits'][credit]['roles']['termPath']
                    }
                    rolesID = shows[show]['_embedded']['credits'][credit]['roles']['id']
                    rolesDict = {
                      id: shows[show]['_embedded']['credits'][credit]['roles']['id'],
                      label: shows[show]['_embedded']['credits'][credit]['roles']['label'],
                      ttl: shows[show]['_embedded']['credits'][credit]['roles']['ttl'],
                      weight: shows[show]['_embedded']['credits'][credit]['roles']['weight'],
                      vid: shows[show]['_embedded']['credits'][credit]['roles']['vid'],
                      type: shows[show]['_embedded']['credits'][credit]['roles']['type'],
                      vocabularyName: shows[show]['_embedded']['credits'][credit]['roles']['vocabularyName'],
                      termPath: shows[show]['_embedded']['credits'][credit]['roles']['termPath']
                    }
                  }
                  if (shows[show]['_embedded']['credits'][credit]['people'] != null) {
                    mainDict['embedded']['credits'][shows[show]['_embedded']['credits'][credit]['id']]['people'] = {
                      id: shows[show]['_embedded']['credits'][credit]['people']['id'],
                      label: shows[show]['_embedded']['credits'][credit]['people']['label'],
                      ttl: shows[show]['_embedded']['credits'][credit]['people']['ttl'],
                      bio: shows[show]['_embedded']['credits'][credit]['people']['bio'],
                      bioSummary: shows[show]['_embedded']['credits'][credit]['people']['bioSummary'],
                      published: shows[show]['_embedded']['credits'][credit]['people']['published'],
                      created: shows[show]['_embedded']['credits'][credit]['people']['created'],
                      changed: shows[show]['_embedded']['credits'][credit]['people']['changed'],
                      sticky: shows[show]['_embedded']['credits'][credit]['people']['sticky'],
                      staff: shows[show]['_embedded']['credits'][credit]['people']['staff']
                    }
                    peopleID = shows[show]['_embedded']['credits'][credit]['people']['id'];
                    peopleDict = {
                      id: shows[show]['_embedded']['credits'][credit]['people']['id'],
                      label: shows[show]['_embedded']['credits'][credit]['people']['label'],
                      ttl: shows[show]['_embedded']['credits'][credit]['people']['ttl'],
                      bio: shows[show]['_embedded']['credits'][credit]['people']['bio'],
                      bioSummary: shows[show]['_embedded']['credits'][credit]['people']['bioSummary'],
                      published: shows[show]['_embedded']['credits'][credit]['people']['published'],
                      created: shows[show]['_embedded']['credits'][credit]['people']['created'],
                      changed: shows[show]['_embedded']['credits'][credit]['people']['changed'],
                      sticky: shows[show]['_embedded']['credits'][credit]['people']['sticky'],
                      staff: shows[show]['_embedded']['credits'][credit]['people']['staff']
                    }
                    if (shows[show]['_embedded']['credits'][credit]['people']['picture'] != null) {
                      mainDict['embedded']['credits'][shows[show]['_embedded']['credits'][credit]['id']]['people']['picture'] = {
                        fid: shows[show]['_embedded']['credits'][credit]['people']['picture']['fid'],
                        url: shows[show]['_embedded']['credits'][credit]['people']['picture']['url'],
                        fileName: shows[show]['_embedded']['credits'][credit]['people']['picture']['fileName'],
                        mimeType: shows[show]['_embedded']['credits'][credit]['people']['picture']['mimeType'],
                        fileSize: shows[show]['_embedded']['credits'][credit]['people']['picture']['fileSize'],
                        width: shows[show]['_embedded']['credits'][credit]['people']['picture']['width'],
                        height: shows[show]['_embedded']['credits'][credit]['people']['picture']['height'],
                        status: shows[show]['_embedded']['credits'][credit]['people']['picture']['status'],
                        changed: shows[show]['_embedded']['credits'][credit]['people']['picture']['changed'],
                        created: shows[show]['_embedded']['credits'][credit]['people']['picture']['created'],
                        derivatives: {
                          thumbnail: shows[show]['_embedded']['credits'][credit]['people']['picture']['derivatives']['thumbnail'],
                          twit_album_art_70x70: shows[show]['_embedded']['credits'][credit]['people']['picture']['derivatives']['twit_album_art_70x70'],
                          twit_album_art_144x144: shows[show]['_embedded']['credits'][credit]['people']['picture']['derivatives']['twit_album_art_144x144'],
                          twit_album_art_240x240: shows[show]['_embedded']['credits'][credit]['people']['picture']['derivatives']['twit_album_art_240x240'],
                          twit_album_art_300x300: shows[show]['_embedded']['credits'][credit]['people']['picture']['derivatives']['twit_album_art_300x300'],
                          twit_album_art_600x600: shows[show]['_embedded']['credits'][credit]['people']['picture']['derivatives']['twit_album_art_600x600'],
                          twit_album_art_1400x1400: shows[show]['_embedded']['credits'][credit]['people']['picture']['derivatives']['twit_album_art_1400x1400'],
                          twit_album_art_2048x2048: shows[show]['_embedded']['credits'][credit]['people']['picture']['derivatives']['twit_album_art_2048x2048']
                        }
                      }
                      peopleDict['picture'] = {
                        fid: shows[show]['_embedded']['credits'][credit]['people']['picture']['fid'],
                        url: shows[show]['_embedded']['credits'][credit]['people']['picture']['url'],
                        fileName: shows[show]['_embedded']['credits'][credit]['people']['picture']['fileName'],
                        mimeType: shows[show]['_embedded']['credits'][credit]['people']['picture']['mimeType'],
                        fileSize: shows[show]['_embedded']['credits'][credit]['people']['picture']['fileSize'],
                        width: shows[show]['_embedded']['credits'][credit]['people']['picture']['width'],
                        height: shows[show]['_embedded']['credits'][credit]['people']['picture']['height'],
                        status: shows[show]['_embedded']['credits'][credit]['people']['picture']['status'],
                        changed: shows[show]['_embedded']['credits'][credit]['people']['picture']['changed'],
                        created: shows[show]['_embedded']['credits'][credit]['people']['picture']['created'],
                        derivatives: {
                          thumbnail: shows[show]['_embedded']['credits'][credit]['people']['picture']['derivatives']['thumbnail'],
                          twit_album_art_70x70: shows[show]['_embedded']['credits'][credit]['people']['picture']['derivatives']['twit_album_art_70x70'],
                          twit_album_art_144x144: shows[show]['_embedded']['credits'][credit]['people']['picture']['derivatives']['twit_album_art_144x144'],
                          twit_album_art_240x240: shows[show]['_embedded']['credits'][credit]['people']['picture']['derivatives']['twit_album_art_240x240'],
                          twit_album_art_300x300: shows[show]['_embedded']['credits'][credit]['people']['picture']['derivatives']['twit_album_art_300x300'],
                          twit_album_art_600x600: shows[show]['_embedded']['credits'][credit]['people']['picture']['derivatives']['twit_album_art_600x600'],
                          twit_album_art_1400x1400: shows[show]['_embedded']['credits'][credit]['people']['picture']['derivatives']['twit_album_art_1400x1400'],
                          twit_album_art_2048x2048: shows[show]['_embedded']['credits'][credit]['people']['picture']['derivatives']['twit_album_art_2048x2048']
                        }
                      }
                    }
                    if (shows[show]['_embedded']['credits'][credit]['people']['relatedLinks'] != null) {
                      for (var relatedLink in shows[show]['_embedded']['credits'][credit]['people']['relatedLinks']) {
                        mainDict['embedded']['credits'][shows[show]['_embedded']['credits'][credit]['id']]['people']['relatedLinks'] = {
                          relatedLink: {
                            title: shows[show]['_embedded']['credits'][credit]['people']['relatedLinks'][relatedLink]['title'],
                            url: shows[show]['_embedded']['credits'][credit]['people']['relatedLinks'][relatedLink]['url']
                          }
                        }
                        peopleDict['relatedLinks'] = {
                          relatedLink: {
                            title: shows[show]['_embedded']['credits'][credit]['people']['relatedLinks'][relatedLink]['title'],
                            url: shows[show]['_embedded']['credits'][credit]['people']['relatedLinks'][relatedLink]['url']
                          }
                        }
                      }
                    } 
                  peopleArray.push(peopleDict)
                }
              }
              if (shows[show]['_embedded']['offers'] != null) {
                for (var offer in shows[show]['_embedded']['offers']) {
                  if (mainDict['embedded'] != null) {
                  mainDict['embedded']['offers'] = {
                      [shows[show]['_embedded']['offers'][offer]['id']]: {
                        id: shows[show]['_embedded']['offers'][offer]['id'],
                        label: shows[show]['_embedded']['offers'][offer]['label'],
                        ttl: shows[show]['_embedded']['offers'][offer]['ttl'],
                        created: shows[show]['_embedded']['offers'][offer]['created'],
                        published: shows[show]['_embedded']['offers'][offer]['published'],
                        changed: shows[show]['_embedded']['offers'][offer]['changed']
                      }
                    }
                    offerID = shows[show]['_embedded']['offers'][offer]['id'];
                    offersDict = {
                      id: shows[show]['_embedded']['offers'][offer]['id'],
                      label: shows[show]['_embedded']['offers'][offer]['label'],
                      ttl: shows[show]['_embedded']['offers'][offer]['ttl'],
                      created: shows[show]['_embedded']['offers'][offer]['created'],
                      published: shows[show]['_embedded']['offers'][offer]['published'],
                      changed: shows[show]['_embedded']['offers'][offer]['changed']
                    }
                    mainDict['embedded']['offerLink'] = {
                      url: shows[show]['_embedded']['offers'][offer]['offerLink']['url'],
                      title: shows[show]['_embedded']['offers'][offer]['offerLink']['title']
                    }
                    offersDict['offerLink'] = {
                      url: shows[show]['_embedded']['offers'][offer]['offerLink']['url'],
                      title: shows[show]['_embedded']['offers'][offer]['offerLink']['title']
                    }
                    if (shows[show]['_embedded']['offers'][offer]['offerSponsor'] != null) {
                      if (shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo'] != null) {
                        mainDict['embedded']['offerSponsor'] = {
                          id: shows[show]['_embedded']['offers'][offer]['offerSponsor']['id'],
                          label: shows[show]['_embedded']['offers'][offer]['offerSponsor']['label'],
                          ttl: shows[show]['_embedded']['offers'][offer]['offerSponsor']['ttl'],
                          body: shows[show]['_embedded']['offers'][offer]['offerSponsor']['body'],
                          published: shows[show]['_embedded']['offers'][offer]['offerSponsor']['published'],
                          created: shows[show]['_embedded']['offers'][offer]['offerSponsor']['created'],
                          changed: shows[show]['_embedded']['offers'][offer]['offerSponsor']['changed'],
                          sticky: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sticky'],
                          sponsorLogo: {
                            fid: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['fid'],
                            url: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['url'],
                            fileName: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['fileName'],
                            mimeType: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['mimeType'],
                            fileSize: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['fileSize'],
                            width: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['width'],
                            height: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['height'],
                            status: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['status'],
                            changed: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['changed'],
                            created: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['created'],
                            derivatives: {
                              thumbnail: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['derivatives']['thumbnail'],
                              twit_slideshow_1600x400: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['derivatives']['twit_slideshow_1600x400'],
                              twit_slideshow_1200x300: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['derivatives']['twit_slideshow_1200x300'],
                              twit_slideshow_800x200: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['derivatives']['twit_slideshow_800x200'],
                              twit_slideshow_600x450: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['derivatives']['twit_slideshow_600x450'],
                              twit_slideshow_400x300: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['derivatives']['twit_slideshow_400x300']
                            }
                          },
                          sponsorWebsite: {
                            url: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorWebsite']['url'],
                            title: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorWebsite']['title']
                          }
                        }
                      }
                    }
                    if (shows[show]['_embedded']['offers'][offer]['offerSponsor'] != null) {
                      if (shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo'] != null) {
                        offersDict['offerSponsor'] = {
                          id: shows[show]['_embedded']['offers'][offer]['offerSponsor']['id'],
                          label: shows[show]['_embedded']['offers'][offer]['offerSponsor']['label'],
                          ttl: shows[show]['_embedded']['offers'][offer]['offerSponsor']['ttl'],
                          body: shows[show]['_embedded']['offers'][offer]['offerSponsor']['body'],
                          published: shows[show]['_embedded']['offers'][offer]['offerSponsor']['published'],
                          created: shows[show]['_embedded']['offers'][offer]['offerSponsor']['created'],
                          changed: shows[show]['_embedded']['offers'][offer]['offerSponsor']['changed'],
                          sticky: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sticky'],
                          sponsorLogo: {
                            fid: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['fid'],
                            url: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['url'],
                            fileName: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['fileName'],
                            mimeType: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['mimeType'],
                            fileSize: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['fileSize'],
                            width: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['width'],
                            height: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['height'],
                            status: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['status'],
                            changed: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['changed'],
                            created: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['created'],
                            derivatives: {
                              thumbnail: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['derivatives']['thumbnail'],
                              twit_slideshow_1600x400: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['derivatives']['twit_slideshow_1600x400'],
                              twit_slideshow_1200x300: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['derivatives']['twit_slideshow_1200x300'],
                              twit_slideshow_800x200: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['derivatives']['twit_slideshow_800x200'],
                              twit_slideshow_600x450: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['derivatives']['twit_slideshow_600x450'],
                              twit_slideshow_400x300: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo']['derivatives']['twit_slideshow_400x300']
                            }
                          },
                          sponsorWebsite: {
                            url: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorWebsite']['url'],
                            title: shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorWebsite']['title']
                          }
                        }
                        offersArray.push(offersDict)
                      }  
                    }
                  }
                }
              }
              if (shows[show]['_embedded']['categories'] != null) {
                for (var category in shows[show]['_embedded']['categories']) {
                  if (mainDict['embedded'] != null) {
                  mainDict['embedded']['categories'] = {
                    [shows[show]['_embedded']['categories'][category]['id']]: {
                      id: shows[show]['_embedded']['categories'][category]['id'],
                      label: shows[show]['_embedded']['categories'][category]['label'],
                      ttl: shows[show]['_embedded']['categories'][category]['ttl'],
                      episodes: {},
                      weight: shows[show]['_embedded']['categories'][category]['weight'],
                      vid: shows[show]['_embedded']['categories'][category]['vid'],
                      type: shows[show]['_embedded']['categories'][category]['type'],
                      vocabularyName: shows[show]['_embedded']['categories'][category]['vocabularyName'],
                      termPath: shows[show]['_embedded']['categories'][category]['termPath']
                    }
                  }
                  }
                }
              }
              if (shows[show]['_embedded']['categories'] != null) {
                for (var category in shows[show]['_embedded']['categories']) {
                  categoriesID = shows[show]['_embedded']['categories'][category]['id'];
                  categoriesDict = {
                    id: shows[show]['_embedded']['categories'][category]['id'],
                    label: shows[show]['_embedded']['categories'][category]['label'],
                    ttl: shows[show]['_embedded']['categories'][category]['ttl'],
                    weight: shows[show]['_embedded']['categories'][category]['weight'],
                    vid: shows[show]['_embedded']['categories'][category]['vid'],
                    type: shows[show]['_embedded']['categories'][category]['type'],
                    vocabularyName: shows[show]['_embedded']['categories'][category]['vocabularyName'],
                    termPath: shows[show]['_embedded']['categories'][category]['termPath']
                  }
                  categoriesArray.push(categoriesDict)
                }
              }
              if (shows[show]['_embedded']['shows'] != null) {
                for (var embeddedShow in shows[show]['_embedded']['shows']) {
                  if (mainDict['embedded'] != null) {
                  mainDict['embedded']['shows'] = {
                    id: shows[show]['_embedded']['shows'][embeddedShow]['id'],
                    label: shows[show]['_embedded']['shows'][embeddedShow]['label'],
                    ttl: shows[show]['_embedded']['shows'][embeddedShow]['ttl'],
                    description: shows[show]['_embedded']['shows'][embeddedShow]['description'],
                    showDate: shows[show]['_embedded']['shows'][embeddedShow]['showDate'],
                    showContactInfo: shows[show]['_embedded']['shows'][embeddedShow]['showContactInfo'],
                    tagLine: shows[show]['_embedded']['shows'][embeddedShow]['tagLine'],
                    shortCode: shows[show]['_embedded']['shows'][embeddedShow]['shortCode'],
                    active: shows[show]['_embedded']['shows'][embeddedShow]['active'],
                    weight: shows[show]['_embedded']['shows'][embeddedShow]['weight'],
                    heroImage: {
                      fid: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['fid'],
                      url: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['url'],
                      fileName: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['fileName'],
                      urmimeTypel: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['mimeType'],
                      fileSize: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['fileSize'],
                      width: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['width'],
                      height: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['height'],
                      status: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['status'],
                      derivatives: {
                        thumbnail: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['derivatives']['thumbnail'],
                        twit_slideshow_1600x400: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['derivatives']['twit_slideshow_1600x400'],
                        twit_slideshow_1200x300: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['derivatives']['twit_slideshow_1200x300'],
                        twit_slideshow_800x200: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['derivatives']['twit_slideshow_800x200'],
                        twit_slideshow_600x450: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['derivatives']['twit_slideshow_600x450'],
                        twit_slideshow_400x300: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['derivatives']['twit_slideshow_400x300']
                      }
                    },
                    coverArt: {
                      fid: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['fid'],
                      url: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['url'],
                      fileName: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['fileName'],
                      urmimeTypel: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['mimeType'],
                      fileSize: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['fileSize'],
                      width: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['width'],
                      height: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['height'],
                      status: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['status'],
                      derivatives: {
                        thumbnail: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['derivatives']['thumbnail'],
                        twit_album_art_70x70: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['derivatives']['twit_album_art_70x70'],
                        twit_album_art_144x144: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['derivatives']['twit_album_art_144x144'],
                        twit_album_art_240x240: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['derivatives']['twit_album_art_240x240'],
                        twit_album_art_300x300: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['derivatives']['twit_album_art_300x300'],
                        twit_album_art_600x600: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['derivatives']['twit_album_art_600x600'],
                        twit_album_art_1400x1400: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['derivatives']['twit_album_art_1400x1400'],
                        twit_album_art_2048x2048: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['derivatives']['twit_album_art_2048x2048']
                      }
                    }
                  }
                  for (var options in shows[show]['_embedded']['shows'][embeddedShow]['hdVideoSubscriptionOptions']) {
                    mainDict['embedded']['shows']['hdVideoSubscriptionOption'] = {
                      [shows[show]['_embedded']['shows'][embeddedShow]['hdVideoSubscriptionOptions'][options['id']]]: {
                        id: shows[show]['_embedded']['shows'][embeddedShow]['hdVideoSubscriptionOptions'][options]['id'],
                        label: shows[show]['_embedded']['shows'][embeddedShow]['hdVideoSubscriptionOptions'][options]['label'],
                        ttl: shows[show]['_embedded']['shows'][embeddedShow]['hdVideoSubscriptionOptions'][options]['ttl'],
                        url: shows[show]['_embedded']['shows'][embeddedShow]['hdVideoSubscriptionOptions'][options]['url'],
                        type: shows[show]['_embedded']['shows'][embeddedShow]['hdVideoSubscriptionOptions'][options]['type'],
                        sticky: shows[show]['_embedded']['shows'][embeddedShow]['hdVideoSubscriptionOptions'][options]['sticky'],
                        feedProvider: {
                          id: shows[show]['_embedded']['shows'][embeddedShow]['hdVideoSubscriptionOptions'][options]['feedProvider']['id'],
                          label: shows[show]['_embedded']['shows'][embeddedShow]['hdVideoSubscriptionOptions'][options]['feedProvider']['label'],
                          ttl: shows[show]['_embedded']['shows'][embeddedShow]['hdVideoSubscriptionOptions'][options]['feedProvider']['ttl'],
                          active: shows[show]['_embedded']['shows'][embeddedShow]['hdVideoSubscriptionOptions'][options]['feedProvider']['active']
                        }
                      }
                    }
                  }
                  for (var options in shows[show]['_embedded']['shows'][embeddedShow]['sdVideoLargeSubscriptionOptions']) {
                    mainDict['embedded']['shows']['sdVideoLargeSubscriptionOptions'] = {
                      [shows[show]['_embedded']['shows'][embeddedShow]['sdVideoLargeSubscriptionOptions'][options['id']]]: {
                        id: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoLargeSubscriptionOptions'][options]['id'],
                        label: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoLargeSubscriptionOptions'][options]['label'],
                        ttl: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoLargeSubscriptionOptions'][options]['ttl'],
                        url: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoLargeSubscriptionOptions'][options]['url'],
                        type: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoLargeSubscriptionOptions'][options]['type'],
                        sticky: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoLargeSubscriptionOptions'][options]['sticky'],
                        feedProvider: {
                          id: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoLargeSubscriptionOptions'][options]['feedProvider']['id'],
                          label: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoLargeSubscriptionOptions'][options]['feedProvider']['label'],
                          ttl: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoLargeSubscriptionOptions'][options]['feedProvider']['ttl'],
                          active: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoLargeSubscriptionOptions'][options]['feedProvider']['active']
                        }
                      }
                    }
                  }
                  for (var options in shows[show]['_embedded']['shows'][embeddedShow]['sdVideoSmallSubscriptionOptions']) {
                    mainDict['embedded']['shows']['sdVideoSmallSubscriptionOptions'] = {
                      [shows[show]['_embedded']['shows'][embeddedShow]['sdVideoSmallSubscriptionOptions'][options['id']]]: {
                        id: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoSmallSubscriptionOptions'][options]['id'],
                        label: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoSmallSubscriptionOptions'][options]['label'],
                        ttl: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoSmallSubscriptionOptions'][options]['ttl'],
                        url: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoSmallSubscriptionOptions'][options]['url'],
                        type: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoSmallSubscriptionOptions'][options]['type'],
                        sticky: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoSmallSubscriptionOptions'][options]['sticky'],
                        feedProvider: {
                          id: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoSmallSubscriptionOptions'][options]['feedProvider']['id'],
                          label: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoSmallSubscriptionOptions'][options]['feedProvider']['label'],
                          ttl: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoSmallSubscriptionOptions'][options]['feedProvider']['ttl']
                        }
                      }
                    }
                  }
                  for (var options in shows[show]['_embedded']['shows'][embeddedShow]['audioSubscriptionOptions']) {
                    mainDict['embedded']['shows']['audioSubscriptionOptions'] = {
                      [shows[show]['_embedded']['shows'][embeddedShow]['audioSubscriptionOptions'][options['id']]]: {
                        id: shows[show]['_embedded']['shows'][embeddedShow]['audioSubscriptionOptions'][options]['id'],
                        label: shows[show]['_embedded']['shows'][embeddedShow]['audioSubscriptionOptions'][options]['label'],
                        ttl: shows[show]['_embedded']['shows'][embeddedShow]['audioSubscriptionOptions'][options]['ttl'],
                        url: shows[show]['_embedded']['shows'][embeddedShow]['audioSubscriptionOptions'][options]['url'],
                        type: shows[show]['_embedded']['shows'][embeddedShow]['audioSubscriptionOptions'][options]['type'],
                        sticky: shows[show]['_embedded']['shows'][embeddedShow]['audioSubscriptionOptions'][options]['sticky'],
                        feedProvider: {
                          id: shows[show]['_embedded']['shows'][embeddedShow]['audioSubscriptionOptions'][options]['feedProvider']['id'],
                          label: shows[show]['_embedded']['shows'][embeddedShow]['audioSubscriptionOptions'][options]['feedProvider']['label'],
                          ttl: shows[show]['_embedded']['shows'][embeddedShow]['audioSubscriptionOptions'][options]['feedProvider']['ttl']
                        }
                      }
                    }
                  }
                if (shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['topics'] != null) {
                  for (var embeddedTopic in shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['topics']) {
                    mainDict['embedded']['shows']['embedded'] = {
                      topics: {
                        [shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['topics'][embeddedTopic]['id']]: {
                          id: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['topics'][embeddedTopic]['id'],
                          label: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['topics'][embeddedTopic]['label'],
                          ttl: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['topics'][embeddedTopic]['ttl'],
                          weight: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['topics'][embeddedTopic]['weight'],
                          vid: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['topics'][embeddedTopic]['vid'],
                          type: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['topics'][embeddedTopic]['type'],
                          vocabularyName: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['topics'][embeddedTopic]['vocabularyName'],
                          termPath: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['topics'][embeddedTopic]['termPath']
                        }
                      }  
                    }
                  }
                }
                if (shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['categories'] != null) {
                  for (var embeddedCategory in shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['categories']) {
                    if(mainDict['embedded']['shows']['embedded'] != null) {
                      mainDict['embedded']['shows']['embedded']['categories'] = {
                        [shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['categories'][embeddedCategory]['id']]: {
                          id: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['categories'][embeddedCategory]['id'],
                          label: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['categories'][embeddedCategory]['label'],
                          ttl: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['categories'][embeddedCategory]['ttl'],
                          vid: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['categories'][embeddedCategory]['vid'],
                          type: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['categories'][embeddedCategory]['type'],
                          vocabularyName: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['categories'][embeddedCategory]['vocabularyName'],
                          termPath: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['categories'][embeddedCategory]['termPath']
                        }
                      }
                    }
                  }
                }
              if (shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'] != null) { 
                for (var embeddedCredit in shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits']) {
                  if(mainDict['embedded']['shows']['embedded'] != null) {
                    mainDict['embedded']['shows']['embedded']['credits'] = {
                      [shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['id']]: {
                        id: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['id'],
                        label: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['label'],
                        ttl: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['ttl']
                      }
                    }
                    if (shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['roles'] != null) {
                      mainDict['embedded']['shows']['embedded']['credits'][shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['id']]['roles'] = {
                        id: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['roles']['id'],
                        label: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['roles']['label'],
                        ttl: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['roles']['ttl'],
                        weight: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['roles']['weight'],
                        vid: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['roles']['vid'],
                        type: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['roles']['type'],
                        vocabularyName: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['roles']['vocabularyName'],
                        termPath: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['roles']['termPath']
                      }
                    }
                    if (shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people'] != null) {
                      mainDict['embedded']['shows']['embedded']['credits'][shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['id']]['people'] = {
                        id: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['id'],
                        label: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['label'],
                        ttl: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['ttl'],
                        bio: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['bio'],
                        bioSummary: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['bioSummary'],
                        published: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['published'],
                        sticky: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['sticky'],
                        staff: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['staff']
                      }
                      if (shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture'] != null) {
                        mainDict['embedded']['shows']['embedded']['credits'][shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['id']]['people']['picture'] = {
                          fid: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['fid'],
                          url: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['url'],
                          fileName: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['fileName'],
                          mimeType: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['mimeType'],
                          fileSize: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['fileSize'],
                          width: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['width'],
                          height: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['height'],
                          status: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['status'],
                          derivatives: {
                            thumbnail: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['derivatives']['thumbnail'],
                            twit_album_art_70x70: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['derivatives']['twit_album_art_70x70'],
                            twit_album_art_144x144: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['derivatives']['twit_album_art_144x144'],
                            twit_album_art_240x240: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['derivatives']['twit_album_art_240x240'],
                            twit_album_art_300x300: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['derivatives']['twit_album_art_300x300'],
                            twit_album_art_600x600: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['derivatives']['twit_album_art_600x600'],
                            twit_album_art_1400x1400: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['derivatives']['twit_album_art_1400x1400'],
                            twit_album_art_2048x2048: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['derivatives']['twit_album_art_2048x2048']
                        }
                      } 
                      if (shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['relatedLinks'] != null) {
                        for (var relatedLink in shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['relatedLinks']) {
                          mainDict['embedded']['shows']['embedded']['credits'][shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['id']]['people']['relatedLinks'] = {
                            relatedLink: {
                              title: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['relatedLinks'][relatedLink]['title'],
                              url: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['relatedLinks'][relatedLink]['url']
                            }
                          }
                        }
                      } 
                    }
                    }
                  }
                }
                }  
              }
                }
              }
              /**************** */

              if (shows[show]['_embedded']['shows'] != null) {
                for (var embeddedShow in shows[show]['_embedded']['shows']) {
                  showsID = shows[show]['_embedded']['shows'][embeddedShow]['id']
                  showDict = {
                    id: shows[show]['_embedded']['shows'][embeddedShow]['id'],
                    label: shows[show]['_embedded']['shows'][embeddedShow]['label'],
                    ttl: shows[show]['_embedded']['shows'][embeddedShow]['ttl'],
                    description: shows[show]['_embedded']['shows'][embeddedShow]['description'],
                    showDate: shows[show]['_embedded']['shows'][embeddedShow]['showDate'],
                    showContactInfo: shows[show]['_embedded']['shows'][embeddedShow]['showContactInfo'],
                    tagLine: shows[show]['_embedded']['shows'][embeddedShow]['tagLine'],
                    shortCode: shows[show]['_embedded']['shows'][embeddedShow]['shortCode'],
                    active: shows[show]['_embedded']['shows'][embeddedShow]['active'],
                    weight: shows[show]['_embedded']['shows'][embeddedShow]['weight'],
                    heroImage: {
                      fid: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['fid'],
                      url: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['url'],
                      fileName: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['fileName'],
                      urmimeTypel: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['mimeType'],
                      fileSize: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['fileSize'],
                      width: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['width'],
                      height: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['height'],
                      status: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['status'],
                      derivatives: {
                        thumbnail: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['derivatives']['thumbnail'],
                        twit_slideshow_1600x400: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['derivatives']['twit_slideshow_1600x400'],
                        twit_slideshow_1200x300: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['derivatives']['twit_slideshow_1200x300'],
                        twit_slideshow_800x200: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['derivatives']['twit_slideshow_800x200'],
                        twit_slideshow_600x450: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['derivatives']['twit_slideshow_600x450'],
                        twit_slideshow_400x300: shows[show]['_embedded']['shows'][embeddedShow]['heroImage']['derivatives']['twit_slideshow_400x300']
                      }
                    },
                    coverArt: {
                      fid: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['fid'],
                      url: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['url'],
                      fileName: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['fileName'],
                      urmimeTypel: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['mimeType'],
                      fileSize: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['fileSize'],
                      width: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['width'],
                      height: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['height'],
                      status: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['status'],
                      derivatives: {
                        thumbnail: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['derivatives']['thumbnail'],
                        twit_album_art_70x70: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['derivatives']['twit_album_art_70x70'],
                        twit_album_art_144x144: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['derivatives']['twit_album_art_144x144'],
                        twit_album_art_240x240: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['derivatives']['twit_album_art_240x240'],
                        twit_album_art_300x300: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['derivatives']['twit_album_art_300x300'],
                        twit_album_art_600x600: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['derivatives']['twit_album_art_600x600'],
                        twit_album_art_1400x1400: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['derivatives']['twit_album_art_1400x1400'],
                        twit_album_art_2048x2048: shows[show]['_embedded']['shows'][embeddedShow]['coverArt']['derivatives']['twit_album_art_2048x2048']
                      }
                    }
                  }
                  for (var options in shows[show]['_embedded']['shows'][embeddedShow]['hdVideoSubscriptionOptions']) {
                    showDict['hdVideoSubscriptionOption'] = {
                      [shows[show]['_embedded']['shows'][embeddedShow]['hdVideoSubscriptionOptions'][options['id']]]: {
                        id: shows[show]['_embedded']['shows'][embeddedShow]['hdVideoSubscriptionOptions'][options]['id'],
                        label: shows[show]['_embedded']['shows'][embeddedShow]['hdVideoSubscriptionOptions'][options]['label'],
                        ttl: shows[show]['_embedded']['shows'][embeddedShow]['hdVideoSubscriptionOptions'][options]['ttl'],
                        url: shows[show]['_embedded']['shows'][embeddedShow]['hdVideoSubscriptionOptions'][options]['url'],
                        type: shows[show]['_embedded']['shows'][embeddedShow]['hdVideoSubscriptionOptions'][options]['type'],
                        sticky: shows[show]['_embedded']['shows'][embeddedShow]['hdVideoSubscriptionOptions'][options]['sticky'],
                        feedProvider: {
                          id: shows[show]['_embedded']['shows'][embeddedShow]['hdVideoSubscriptionOptions'][options]['feedProvider']['id'],
                          label: shows[show]['_embedded']['shows'][embeddedShow]['hdVideoSubscriptionOptions'][options]['feedProvider']['label'],
                          ttl: shows[show]['_embedded']['shows'][embeddedShow]['hdVideoSubscriptionOptions'][options]['feedProvider']['ttl'],
                          active: shows[show]['_embedded']['shows'][embeddedShow]['hdVideoSubscriptionOptions'][options]['feedProvider']['active']
                        }
                      }
                    }
                  }
                  for (var options in shows[show]['_embedded']['shows'][embeddedShow]['sdVideoLargeSubscriptionOptions']) {
                    showDict['sdVideoLargeSubscriptionOptions'] = {
                      [shows[show]['_embedded']['shows'][embeddedShow]['sdVideoLargeSubscriptionOptions'][options['id']]]: {
                        id: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoLargeSubscriptionOptions'][options]['id'],
                        label: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoLargeSubscriptionOptions'][options]['label'],
                        ttl: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoLargeSubscriptionOptions'][options]['ttl'],
                        url: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoLargeSubscriptionOptions'][options]['url'],
                        type: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoLargeSubscriptionOptions'][options]['type'],
                        sticky: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoLargeSubscriptionOptions'][options]['sticky'],
                        feedProvider: {
                          id: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoLargeSubscriptionOptions'][options]['feedProvider']['id'],
                          label: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoLargeSubscriptionOptions'][options]['feedProvider']['label'],
                          ttl: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoLargeSubscriptionOptions'][options]['feedProvider']['ttl'],
                          active: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoLargeSubscriptionOptions'][options]['feedProvider']['active']
                        }
                      }
                    }
                  }
                  for (var options in shows[show]['_embedded']['shows'][embeddedShow]['sdVideoSmallSubscriptionOptions']) {
                    showDict['sdVideoSmallSubscriptionOptions'] = {
                      [shows[show]['_embedded']['shows'][embeddedShow]['sdVideoSmallSubscriptionOptions'][options['id']]]: {
                        id: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoSmallSubscriptionOptions'][options]['id'],
                        label: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoSmallSubscriptionOptions'][options]['label'],
                        ttl: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoSmallSubscriptionOptions'][options]['ttl'],
                        url: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoSmallSubscriptionOptions'][options]['url'],
                        type: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoSmallSubscriptionOptions'][options]['type'],
                        sticky: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoSmallSubscriptionOptions'][options]['sticky'],
                        feedProvider: {
                          id: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoSmallSubscriptionOptions'][options]['feedProvider']['id'],
                          label: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoSmallSubscriptionOptions'][options]['feedProvider']['label'],
                          ttl: shows[show]['_embedded']['shows'][embeddedShow]['sdVideoSmallSubscriptionOptions'][options]['feedProvider']['ttl']
                        }
                      }
                    }
                  }
                  for (var options in shows[show]['_embedded']['shows'][embeddedShow]['audioSubscriptionOptions']) {
                    showDict['audioSubscriptionOptions'] = {
                      [shows[show]['_embedded']['shows'][embeddedShow]['audioSubscriptionOptions'][options['id']]]: {
                        id: shows[show]['_embedded']['shows'][embeddedShow]['audioSubscriptionOptions'][options]['id'],
                        label: shows[show]['_embedded']['shows'][embeddedShow]['audioSubscriptionOptions'][options]['label'],
                        ttl: shows[show]['_embedded']['shows'][embeddedShow]['audioSubscriptionOptions'][options]['ttl'],
                        url: shows[show]['_embedded']['shows'][embeddedShow]['audioSubscriptionOptions'][options]['url'],
                        type: shows[show]['_embedded']['shows'][embeddedShow]['audioSubscriptionOptions'][options]['type'],
                        sticky: shows[show]['_embedded']['shows'][embeddedShow]['audioSubscriptionOptions'][options]['sticky'],
                        feedProvider: {
                          id: shows[show]['_embedded']['shows'][embeddedShow]['audioSubscriptionOptions'][options]['feedProvider']['id'],
                          label: shows[show]['_embedded']['shows'][embeddedShow]['audioSubscriptionOptions'][options]['feedProvider']['label'],
                          ttl: shows[show]['_embedded']['shows'][embeddedShow]['audioSubscriptionOptions'][options]['feedProvider']['ttl']
                        }
                      }
                    }
                  }
                }
                if (shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['topics'] != null) {
                  for (var embeddedTopic in shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['topics']) {
                    showDict['embedded'] = {
                      topics: {
                        [shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['topics'][embeddedTopic]['id']]: {
                          id: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['topics'][embeddedTopic]['id'],
                          label: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['topics'][embeddedTopic]['label'],
                          ttl: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['topics'][embeddedTopic]['ttl'],
                          weight: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['topics'][embeddedTopic]['weight'],
                          vid: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['topics'][embeddedTopic]['vid'],
                          type: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['topics'][embeddedTopic]['type'],
                          vocabularyName: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['topics'][embeddedTopic]['vocabularyName'],
                          termPath: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['topics'][embeddedTopic]['termPath']
                        }
                      }  
                    }
                  }
                }
                if (shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['categories'] != null) {
                  for (var embeddedCategory in shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['categories']) {
                    if (showDict['embedded'] != null) { 
                      showDict['embedded']['categories'] = {
                        [shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['categories'][embeddedCategory]['id']]: {
                          id: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['categories'][embeddedCategory]['id'],
                          label: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['categories'][embeddedCategory]['label'],
                          ttl: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['categories'][embeddedCategory]['ttl'],
                          vid: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['categories'][embeddedCategory]['vid'],
                          type: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['categories'][embeddedCategory]['type'],
                          vocabularyName: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['categories'][embeddedCategory]['vocabularyName'],
                          termPath: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['categories'][embeddedCategory]['termPath']
                        }
                      }
                    }
                  }
                }
              if (shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'] != null) { 
                for (var embeddedCredit in shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits']) {
                  if (showDict['embedded'] != null) { 
                    showDict['embedded']['credits'] = {
                      [shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['id']]: {
                        id: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['id'],
                        label: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['label'],
                        ttl: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['ttl']
                      }
                    }
                    if (shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['roles'] != null) {
                      showDict['embedded']['credits'][shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['id']]['roles'] = {
                        id: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['roles']['id'],
                        label: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['roles']['label'],
                        ttl: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['roles']['ttl'],
                        weight: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['roles']['weight'],
                        vid: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['roles']['vid'],
                        type: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['roles']['type'],
                        vocabularyName: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['roles']['vocabularyName'],
                        termPath: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['roles']['termPath']
                      }
                    }
                    if (shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people'] != null) {
                      showDict['embedded']['credits'][shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['id']]['people'] = {
                        id: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['id'],
                        label: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['label'],
                        ttl: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['ttl'],
                        bio: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['bio'],
                        bioSummary: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['bioSummary'],
                        published: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['published'],
                        sticky: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['sticky'],
                        staff: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['staff']
                      }
                      if (shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture'] != null) {
                        showDict['embedded']['credits'][shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['id']]['people']['picture'] = {
                          fid: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['fid'],
                          url: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['url'],
                          fileName: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['fileName'],
                          mimeType: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['mimeType'],
                          fileSize: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['fileSize'],
                          width: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['width'],
                          height: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['height'],
                          status: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['status'],
                          derivatives: {
                            thumbnail: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['derivatives']['thumbnail'],
                            twit_album_art_70x70: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['derivatives']['twit_album_art_70x70'],
                            twit_album_art_144x144: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['derivatives']['twit_album_art_144x144'],
                            twit_album_art_240x240: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['derivatives']['twit_album_art_240x240'],
                            twit_album_art_300x300: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['derivatives']['twit_album_art_300x300'],
                            twit_album_art_600x600: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['derivatives']['twit_album_art_600x600'],
                            twit_album_art_1400x1400: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['derivatives']['twit_album_art_1400x1400'],
                            twit_album_art_2048x2048: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['picture']['derivatives']['twit_album_art_2048x2048']
                        }
                      } 
                      if (shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['relatedLinks'] != null) {
                        for (var relatedLink in shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['relatedLinks']) {
                          showDict['embedded']['credits'][shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['id']]['people']['relatedLinks'] = {
                            relatedLink: {
                              title: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['relatedLinks'][relatedLink]['title'],
                              url: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['relatedLinks'][relatedLink]['url']
                            }
                          }
                        }
                      } 
                    }
                  }
                }
                }  
              }
              }
              /*************** */
            }
            if (shows[show]['video_youtube'] != null) {
                mainDict["video_youtube"] = shows[show]['video_youtube'];
            };

            if (shows[show]['heroImage'] != null) {
              mainDict["heroImage"] = {
                fid: shows[show]['heroImage']['fid'],
                url: shows[show]['heroImage']['url'],
                fileName: shows[show]['heroImage']['fileName'],
                mimeType: shows[show]['heroImage']['mimeType'],
                fileSize: shows[show]['heroImage']['fileSize'],
                width: shows[show]['heroImage']['width'],
                height: shows[show]['heroImage']['height'],
                alt: shows[show]['heroImage']['alt'],
                title: shows[show]['heroImage']['title'],
                status: shows[show]['heroImage']['status']
              };
              if (shows[show]['heroImage']['derivatives'] != null) {
                mainDict['heroImage']['derivatives'] = {
                  thumbnail: shows[show]['heroImage']['derivatives']['thumbnail'],
                  twit_slideshow_1600x400: shows[show]['heroImage']['derivatives']['twit_slideshow_1600x400'],
                  twit_slideshow_1200x300: shows[show]['heroImage']['derivatives']['twit_slideshow_1200x300'],
                  twit_slideshow_800x200: shows[show]['heroImage']['derivatives']['twit_slideshow_800x200'],
                  twit_slideshow_600x450: shows[show]['heroImage']['derivatives']['twit_slideshow_600x450'],
                  twit_slideshow_400x300: shows[show]['heroImage']['derivatives']['twit_slideshow_400x300']
                }
              }
            };
              
              episodesRef.child(showNumber).child(shows[show]['id']).set(mainDict);
              episodesRef.child("allEpisodes").child(shows[show]['id']).set(mainDict);
              showRef.child(showsID).set(showDict);
              for (test in peopleArray) {
                peopleRef.child(peopleArray[test]['id']).set(peopleArray[test]);
                if (shows[show]['_embedded']['credits'][credit]['people']['staff'] == true) {
                  castRef.child(peopleArray[test]['id']).set(peopleArray[test]);
                }
              }
              for (test in offersArray) {
                offersRef.child(offersArray[test]['id']).set(offersArray[test]);
              }
              for (test in categoriesArray) {
                categoriesRef.child(categoriesArray[test]['id']).set(categoriesArray[test]);
              }
              if (mainDict['embedded'] != null) {
                if (mainDict['embedded']['shows'] != null) {
                  if (shows[show]['_embedded']['shows'][embeddedShow]['active'] == true) {
                    console.log('ACTIVE SHOW');
                    activeShowRef.child(showsID).set(showDict);
                  }
                }
              }

              //THIS IS WHERE WE CHECK FOR CATEGORY type
              if (mainDict['embedded'] != null) {
                if (mainDict['embedded']['categories'] != null) {
                  for (var category in shows[show]['_embedded']['categories']) {
                    console.log(shows[show]['_embedded']['categories'][category]['id'])
                    console.log(shows[show]['_embedded']['categories'][category]['label'])
                    console.log(shows[show]['id'])                    
                    var showID = shows[show]['_embedded']['categories'][category]['id']
                    categoryEpisodesRef.child(showID).child(shows[show]['id']).set(mainDict);
                  }
                }
              }


              rolesRef.child(rolesID).set(rolesDict);
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
module.exports.deletefirebase = deletefirebase;