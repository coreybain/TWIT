var firebase = require("firebase");
var mongoose = require('mongoose');

var Shows = require('../Schemas/showsSchema');
var ActiveShows = require('../Schemas/activeShowSchema');
var Categories = require('../Schemas/categorySchema');

mongoose.connect('mongodb://localhost/TwitTest');

var app = firebase.initializeApp({
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
  console.log('DELETING ALL DATA ENTRIES');
  db.ref("Shows").remove();
  db.ref("episodes").remove();
  db.ref("activeShows").remove();
  db.ref("people").remove();
  db.ref("cast").remove();
  db.ref("roles").remove();
  db.ref("offers").remove();
  db.ref("categories").remove();
  db.ref("categoryEpisodes").remove();
}

function extend(target) {
    var sources = [].slice.call(arguments, 1);
    sources.forEach(function (source) {
        for (var prop in source) {
            target[prop] = source[prop];
        }
    });
    return target;
}

function firebaseEpisodeSync(dbRef, showNumber, data, callback) {
      var shows = data['episodes'];
    episodesRef.child('count').on("value", function(snapshot) {
       var uploadCount = 0
          for (var show in shows) {

            var showDict = {}
            showDict[showNumber] = {}
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
            var episodeDict = {};

            var mainDict = {};
            mainDict['episodes'] = {}
            mainDict['episodes'][showNumber] = {}

            episodeDict["info"] = {
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
                episodeDict["info"]["video_audio"] = {
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
                episodeDict["info"]["video_hd"] = {
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
                episodeDict["info"]["video_large"] = {
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
                episodeDict["info"]["video_small"] = {
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

              //Upload information about shows based on episode
              episodeDict["show"] = {}
            if (shows[show]['_embedded'] != null) {
              episodeDict["show"]["credits"] = {}
              episodeDict["show"]["people"] = {}
                //Upload cast credit information
              for (var credit in shows[show]['_embedded']['credits']) {
                episodeDict["show"]["credits"][shows[show]['_embedded']['credits'][credit]['id']] = {
                  id: shows[show]['_embedded']['credits'][credit]['id'],
                  label: shows[show]['_embedded']['credits'][credit]['label'],
                  ttl: shows[show]['_embedded']['credits'][credit]['ttl'],
                  created: shows[show]['_embedded']['credits'][credit]['created']
                }
                //Upload Cast Roles
                if (shows[show]['_embedded']['credits'][credit]['roles'] != null) {
                  episodeDict["show"]["credits"][shows[show]['_embedded']['credits'][credit]['id']]['roles'] = {
                    id: shows[show]['_embedded']['credits'][credit]['roles']['id'],
                    label: shows[show]['_embedded']['credits'][credit]['roles']['label'],
                    ttl: shows[show]['_embedded']['credits'][credit]['roles']['ttl'],
                    weight: shows[show]['_embedded']['credits'][credit]['roles']['weight'],
                    vid: shows[show]['_embedded']['credits'][credit]['roles']['vid'],
                    type: shows[show]['_embedded']['credits'][credit]['roles']['type'],
                    vocabularyName: shows[show]['_embedded']['credits'][credit]['roles']['vocabularyName'],
                    termPath: shows[show]['_embedded']['credits'][credit]['roles']['termPath']
                  }
                  //Upload role information
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
                //Upload Cast People Information
                  if (shows[show]['_embedded']['credits'][credit]['people'] != null) {
                    episodeDict["show"]["people"][shows[show]['_embedded']['credits'][credit]['people']['id']] = {
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
                      episodeDict["show"]["people"][shows[show]['_embedded']['credits'][credit]['people']['id']]['picture'] = {
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
                      episodeDict["show"]["people"][shows[show]['_embedded']['credits'][credit]['people']['id']]['relatedLinks'] = {}
                      for (var relatedLink in shows[show]['_embedded']['credits'][credit]['people']['relatedLinks']) {
                         episodeDict["show"]["people"][shows[show]['_embedded']['credits'][credit]['people']['id']]['relatedLinks'][Object.keys(shows[show]['_embedded']['credits'][credit]['people']['relatedLinks']).indexOf(relatedLink)] = {
                            title: shows[show]['_embedded']['credits'][credit]['people']['relatedLinks'][relatedLink]['title'],
                            url: shows[show]['_embedded']['credits'][credit]['people']['relatedLinks'][relatedLink]['url']
                        }
                        peopleDict['relatedLinks'] = {}
                        peopleDict['relatedLinks'][Object.keys(shows[show]['_embedded']['credits'][credit]['people']['relatedLinks']).indexOf(relatedLink)] = {
                            title: shows[show]['_embedded']['credits'][credit]['people']['relatedLinks'][relatedLink]['title'],
                            url: shows[show]['_embedded']['credits'][credit]['people']['relatedLinks'][relatedLink]['url']
                        }
                      }
                    }
                  peopleArray.push(peopleDict)
                }
              }
            }


            if (shows[show]['_embedded'] != null) {
              episodeDict['embedded'] = {}

              //Upload information about shows based on episode
              if (shows[show]['_embedded']['offers'] != null) {
              episodeDict["show"]["offers"] = {}
                for (var offer in shows[show]['_embedded']['offers']) {
                  if (episodeDict['embedded'] != null) {
                  episodeDict["show"]['offers'][shows[show]['_embedded']['offers'][offer]['id']] = {
                      id: shows[show]['_embedded']['offers'][offer]['id'],
                      label: shows[show]['_embedded']['offers'][offer]['label'],
                      ttl: shows[show]['_embedded']['offers'][offer]['ttl'],
                      created: shows[show]['_embedded']['offers'][offer]['created'],
                      published: shows[show]['_embedded']['offers'][offer]['published'],
                      changed: shows[show]['_embedded']['offers'][offer]['changed']
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
                    episodeDict["show"]['offers'][shows[show]['_embedded']['offers'][offer]['id']]['offerLink'] = {
                      url: shows[show]['_embedded']['offers'][offer]['offerLink']['url'],
                      title: shows[show]['_embedded']['offers'][offer]['offerLink']['title']
                    }
                    offersDict['offerLink'] = {
                      url: shows[show]['_embedded']['offers'][offer]['offerLink']['url'],
                      title: shows[show]['_embedded']['offers'][offer]['offerLink']['title']
                    }
                    if (shows[show]['_embedded']['offers'][offer]['offerSponsor'] != null) {
                      if (shows[show]['_embedded']['offers'][offer]['offerSponsor']['sponsorLogo'] != null) {
                        episodeDict["show"]['offers'][shows[show]['_embedded']['offers'][offer]['id']]['offerSponsor'] = {
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
                          showID: shows[show]['id'],
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
                episodeDict["show"]['categories'] = {}
                for (var category in shows[show]['_embedded']['categories']) {
                  if (episodeDict['embedded'] != null) {
                  episodeDict["show"]['categories'][shows[show]['_embedded']['categories'][category]['id']] = {
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
                  if (episodeDict['embedded'] != null) {
                  episodeDict["show"]['info'] = {
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
                    episodeDict["show"]['info']['hdVideoSubscriptionOption'] = {
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
                    episodeDict["show"]['info']['sdVideoLargeSubscriptionOptions'] = {
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
                    episodeDict["show"]['info']['sdVideoSmallSubscriptionOptions'] = {
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
                    episodeDict["show"]['info']['audioSubscriptionOptions'] = {
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
                  episodeDict["show"]['topics'] = {}
                  for (var embeddedTopic in shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['topics']) {
                    episodeDict["show"]['topics'][shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['topics'][embeddedTopic]['id']] = {
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
              if (shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'] != null) {
                episodeDict["show"]['credits'] = {}
                for (var embeddedCredit in shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits']) {
                  if(episodeDict["show"]['topics'] != null) {
                    episodeDict["show"]['credits'][shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['id']] = {
                      id: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['id'],
                      label: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['label'],
                      ttl: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['ttl']
                    }
                    if (shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['roles'] != null) {
                      episodeDict["show"]['credits'][shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['id']]['roles'] = {
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
                      episodeDict["show"]['people'][shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['id']] = {
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
                        episodeDict["show"]['people'][shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['id']]['picture'] = {
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
                        episodeDict["show"]['people'][shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['id']]['relatedLinks'] = {}
                        var counter = 0
                        for (var relatedLink in shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['relatedLinks']) {
                          episodeDict["show"]['people'][shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['id']]['relatedLinks'][counter] = {
                              title: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['relatedLinks'][relatedLink]['title'],
                              url: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['relatedLinks'][relatedLink]['url']
                            }
                            counter++
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
                   showDict['info'] = {
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
                  if (shows[show]['_embedded']['shows'][embeddedShow]['hdVideoSubscriptionOptions'] != null) {
                     showDict['info']['hdVideoSubscriptionOption'] = {}
                    for (var options in shows[show]['_embedded']['shows'][embeddedShow]['hdVideoSubscriptionOptions']) {
                       showDict['info']['hdVideoSubscriptionOption'] = {
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
                  if (shows[show]['_embedded']['shows'][embeddedShow]['sdVideoLargeSubscriptionOptions'] != null) {
                     showDict['info']['sdVideoLargeSubscriptionOptions'] = {}
                    for (var options in shows[show]['_embedded']['shows'][embeddedShow]['sdVideoLargeSubscriptionOptions']) {
                       showDict['info']['sdVideoLargeSubscriptionOptions'] = {
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
                  if (shows[show]['_embedded']['shows'][embeddedShow]['sdVideoSmallSubscriptionOptions'] != null) {
                   showDict['info']['sdVideoSmallSubscriptionOptions'] = {}
                  for (var options in shows[show]['_embedded']['shows'][embeddedShow]['sdVideoSmallSubscriptionOptions']) {
                     showDict['info']['sdVideoSmallSubscriptionOptions'] = {
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
                  if (shows[show]['_embedded']['shows'][embeddedShow]['audioSubscriptionOptions'] != null) {
                     showDict['info']['audioSubscriptionOptions'] = {}
                  for (var options in shows[show]['_embedded']['shows'][embeddedShow]['audioSubscriptionOptions']) {
                     showDict['info']['audioSubscriptionOptions'] = {
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
                   showDict['topics'] = {}
                  for (var embeddedTopic in shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['topics']) {
                     showDict['topics'][shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['topics'][embeddedTopic]['id']] = {
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
                if (shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['categories'] != null) {
                   showDict['categories'] = {}
                  for (var embeddedCategory in shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['categories']) {
                     showDict['categories'][shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['categories'][embeddedCategory]['id']] = {
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
              if (shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'] != null) {
                 showDict['people'] = {}
                for (var embeddedCredit in shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits']) {
                    if (shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people'] != null) {
                       showDict['people'][shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['id']] = {
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
                         showDict['people'][shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['id']]['picture'] = {
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
                         showDict['people'][shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['id']]['relatedLinks'] = {}
                        var counter = 0
                        for (var relatedLink in shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['relatedLinks']) {
                           showDict['people'][shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['id']]['relatedLinks'][counter] = {
                              title: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['relatedLinks'][relatedLink]['title'],
                              url: shows[show]['_embedded']['shows'][embeddedShow]['_embedded']['credits'][embeddedCredit]['people']['relatedLinks'][relatedLink]['url']
                            }
                          counter++
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
                episodeDict["video_youtube"] = shows[show]['video_youtube'];
            };

            if (shows[show]['heroImage'] != null) {
              episodeDict["heroImage"] = {
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
                episodeDict['heroImage']['derivatives'] = {
                  thumbnail: shows[show]['heroImage']['derivatives']['thumbnail'],
                  twit_slideshow_1600x400: shows[show]['heroImage']['derivatives']['twit_slideshow_1600x400'],
                  twit_slideshow_1200x300: shows[show]['heroImage']['derivatives']['twit_slideshow_1200x300'],
                  twit_slideshow_800x200: shows[show]['heroImage']['derivatives']['twit_slideshow_800x200'],
                  twit_slideshow_600x450: shows[show]['heroImage']['derivatives']['twit_slideshow_600x450'],
                  twit_slideshow_400x300: shows[show]['heroImage']['derivatives']['twit_slideshow_400x300']
                }
              }
            };

            var showRawID = shows[show]['_embedded']['shows'][embeddedShow]['id'];
            //var object = ObjectId.fromString(showNumber);
            var info = showDict['info']
            var topics = showDict['topics']
            var categories = showDict['categories']
            var people = showDict['people']
            var newShow = new Shows({
              _id: showNumber,
              info: info,
              topics: topics,
              categories: categories,
              people: people
            });
            if (episodeDict["show"] != null) {
              if (shows[show]['_embedded']['shows'][embeddedShow]['active'] == true) {
                var activeShow = new ActiveShows({
                  _id: showNumber,
                  info: info,
                  topics: topics,
                  categories: categories,
                  people: people
                });
              }
            }

            if (showDict['categories'] != null) {
            var categoriesID = showDict['categories']['id']
            var labelRaw = showDict['categories']['label']
            var ttlRaw = showDict['categories']['ttl']
            var weightRaw = showDict['categories']['weight']
            var vidRaw = showDict['categories']['vid']
            var typeRaw = showDict['categories']['type']
            var vocabularyNameRaw = showDict['categories']['vocabularyName']
            var termPathRaw = showDict['categories']['termPath']
              var categorySchema = new Categories({
                _id: categoriesID,
                label: labelRaw,
                ttl: ttlRaw,
                weight: weightRaw,
                vid: vidRaw,
                type: typeRaw,
                vocabularyName: vocabularyNameRaw,
                termPath: termPathRaw
              })
            }






            Shows.findOne({_id:showNumber}, function(err, show) {
              if (err) {
                console.log('error found')
                console.log('COMPLETE without posting show');
                function2();
                callback(true);
              }
              if (!show) {
                newShow.save(function(err) {
                  if (err) {
                    return console.log(err)
                  } else {
                  console.log('Show saved successfully to mongoDB!');
                  if (showDict['categories'] != null) {
                    categorySchema.save(function(err) {
                      if (err) {
                        return console.log(err)
                      } else {
                        if (shows[show]['_embedded']['shows'][embeddedShow]['active'] == true) {
                          activeShow.save(function(err) {
                            if (err) {
                              return console.log(err)
                            } else {
                            console.log('Active show saved successfully to mongoDB!');
                            console.log('COMPLETE');
                            function2();
                            callback(true);
                            }
                          });
                        } else {
                        console.log('COMPLETE');
                        function2();
                        callback(true);
                        }
                      }
                    });
                  }
                  console.log('COMPLETE');
                  function2();
                  callback(true);
                  }
                });
              } else {

                console.log('Show is already in the database --> skipping upload');
                function2();
                callback(true);
              }
            });



            //
            // for (test in categoriesArray) {
            //   console.log('Categories info saved successfully.')
            //   categoriesRef.child(categoriesArray[test]['id']).set(categoriesArray[test]);
            // }
            //
            //   // Upload basic show information to firebase
            //   console.log('WORKING...');
            //   showRef.child(showNumber).set(showDict, function(error) {
            //     if (error) {
            //       console.log("Data could not be saved." + error);
            //     } else {
            //       console.log("Show Data saved successfully.");
            //       episodesRef.child(showNumber).child('allEpisodes').child(shows[show]['id']).set(episodeDict, function(error) {
            //         if (error) {
            //           console.log("Data could not be saved." + error);
            //         } else {
            //           console.log("Show Episode Data saved successfully.");
            //           episodesRef.child("allEpisodes").child(shows[show]['id']).set(episodeDict, function(error) {
            //             if (error) {
            //               console.log("Data could not be saved." + error);
            //             } else {
            //               console.log("AllEpisode Data saved successfully.");
            //               if (episodeDict["show"] != null) {
            //                 if (shows[show]['_embedded']['shows'][embeddedShow]['active'] == true) {
            //                   console.log('ACTIVE SHOW');
            //                   activeShowRef.child(showNumber).set(showDict, function(error) {
            //                     if (error) {
            //                       console.log("Data could not be saved." + error);
            //                     } else {
            //                       console.log("Active Show Data saved successfully.");
            //                       var seasonID = 0
            //                       var seasonRaw = parseInt(shows[show]['episodeNumber']) / 25
            //                       var seasonRound = (Math.round(seasonRaw));
            //                       if  (seasonRaw <= 1) {
            //                         seasonRaw = 0
            //                         seasonID = (Math.round(seasonRaw) + 1);
            //                       } else if (seasonRaw > seasonRound) {
            //                         seasonID = (Math.round(seasonRaw) + 1);
            //                       } else {
            //                         seasonID = (Math.round(seasonRaw));
            //                       }
            //                       episodesRef.child(showNumber).child('seasons').child('season ' + seasonID).child(shows[show]['id']).set(episodeDict, function(error) {
            //                         if (error) {
            //                           console.log("Data could not be saved." + error);
            //                         } else {
            //                           console.log("Season episode info saved successfully.");
            //                           for (test in peopleArray) {
            //                             console.log('People info saved successfully.')
            //                             peopleRef.child(peopleArray[test]['id']).child("info").set(peopleArray[test]);
            //                             peopleRef.child(peopleArray[test]['id']).child("episodes").child(shows[show]['id']).set(episodeDict);
            //                             peopleRef.child(peopleArray[test]['id']).child("shows").child(showsID).set(showDict);
            //                             if (shows[show]['_embedded']['credits'][credit]['people']['staff'] == true) {
            //                               console.log('Cast info saved successfully.')
            //                               castRef.child(peopleArray[test]['id']).child("info").set(peopleArray[test]);
            //                               castRef.child(peopleArray[test]['id']).child("episodes").child(shows[show]['id']).set(episodeDict);
            //                               castRef.child(peopleArray[test]['id']).child("shows").child(showsID).set(showDict);
            //                             }
            //                           }
            //                           for (test in offersArray) {
            //                             console.log('Offers info saved successfully.')
            //                             offersRef.child(offersArray[test]['id']).set(offersArray[test]);
            //                           }
            //
            //                           for (test in categoriesArray) {
            //                             console.log('Categories info saved successfully.')
            //                             categoriesRef.child(categoriesArray[test]['id']).set(categoriesArray[test]);
            //                           }
            //                           if (episodeDict["show"] != null) {
            //                             console.log('SHOW IS HERE')
            //                             if (episodeDict["show"]['categories'] != null) {
            //                             console.log('CATEGORIES IS HERE')
            //                               for (var category in shows[show]['_embedded']['categories']) {
            //                                 categoryEpisodesRef.child(shows[show]['_embedded']['categories'][category]['id']).child(shows[show]['id']).set(episodeDict, function(error) {
            //                                   if (error) {
            //                                     console.log("Data could not be saved." + error);
            //                                   } else {
            //                                     console.log("category/offers/people data saved successfully.");
            //                                     rolesRef.child(rolesID).set(rolesDict, function(error) {
            //                                       if (error) {
            //                                         console.log("Data could not be saved." + error);
            //                                       } else {
            //                                         console.log("roles information saved successfully.");
            //                                         console.log('COMPLETE');
            //                                         uploadCount++
            //                                         if (uploadCount == shows.length) {
            //                                           Shows.findOne({_id:showNumber}, function(err, show) {
            //                                             if (err) {
            //                                               console.log('error found')
            //                                               console.log('COMPLETE without posting show');
            //                                               function2();
            //                                               callback(true);
            //                                             }
            //                                             if (!show) {
            //                                               newShow.save(function(err) {
            //                                                 if (err) {
            //                                                   return console.log(err)
            //                                                 } else {
            //                                                 console.log('Show saved successfully to mongoDB!');
            //                                                   if (shows[show]['_embedded']['shows'][embeddedShow]['active'] == true) {
            //                                                     activeShow.save(function(err) {
            //                                                       if (err) {
            //                                                         return console.log(err)
            //                                                       } else {
            //                                                       console.log('Active show saved successfully to mongoDB!');
            //                                                       console.log('COMPLETE');
            //                                                       function2();
            //                                                       callback(true);
            //                                                       }
            //                                                     });
            //                                                   } else {
            //                                                   console.log('COMPLETE');
            //                                                   function2();
            //                                                   callback(true);
            //                                                   }
            //                                                 console.log('COMPLETE');
            //                                                 function2();
            //                                                 callback(true);
            //                                                 }
            //                                               });
            //                                             } else {
            //                                               console.log('Show is already in the database --> skipping upload');
            //                                               function2();
            //                                               callback(true);
            //                                             }
            //                                           });
            //                                         }
            //                                       }
            //                                     });
            //                                   }
            //                                 });
            //                               }
            //                             } else {
            //                               rolesRef.child(rolesID).set(rolesDict, function(error) {
            //                                 if (error) {
            //                                   console.log("Data could not be saved." + error);
            //                                 } else {
            //                                   console.log("roles information saved successfully.");
            //                                   console.log('COMPLETE');
            //                                   uploadCount++
            //                                   if (uploadCount == shows.length) {
            //                                     console.log('COMPLETE');
            //                                     function2();
            //                                     callback(true);
            //                                   }
            //                                 }
            //                               });
            //                             }
            //                           }
            //                         }
            //                       });
            //                     }
            //                   });
            //                 } else {
            //                   var seasonID = 0
            //                   var seasonRaw = parseInt(shows[show]['episodeNumber']) / 25
            //                   var seasonRound = (Math.round(seasonRaw));
            //                   if  (seasonRaw <= 1) {
            //                     seasonRaw = 0
            //                     seasonID = (Math.round(seasonRaw) + 1);
            //                   } else if (seasonRaw > seasonRound) {
            //                     seasonID = (Math.round(seasonRaw) + 1);
            //                   } else {
            //                     seasonID = (Math.round(seasonRaw));
            //                   }
            //                   episodesRef.child(showNumber).child('seasons').child('season ' + seasonID).child(shows[show]['id']).set(episodeDict, function(error) {
            //                     if (error) {
            //                       console.log("Data could not be saved." + error);
            //                     } else {
            //                       console.log("Season episode info saved successfully.");
            //                       for (test in peopleArray) {
            //                         console.log('People info saved successfully.')
            //                         peopleRef.child(peopleArray[test]['id']).child("info").set(peopleArray[test]);
            //                         peopleRef.child(peopleArray[test]['id']).child("episodes").child(shows[show]['id']).set(episodeDict);
            //                         peopleRef.child(peopleArray[test]['id']).child("shows").child(showsID).set(showDict);
            //                         if (shows[show]['_embedded']['credits'][credit]['people']['staff'] == true) {
            //                         console.log('Cast info saved successfully.')
            //                           castRef.child(peopleArray[test]['id']).child("info").set(peopleArray[test]);
            //                           castRef.child(peopleArray[test]['id']).child("episodes").child(shows[show]['id']).set(episodeDict);
            //                           castRef.child(peopleArray[test]['id']).child("shows").child(showsID).set(showDict);
            //                         }
            //                       }
            //                       for (test in offersArray) {
            //                         console.log('Offers info saved successfully.')
            //                         offersRef.child(offersArray[test]['id']).set(offersArray[test]);
            //                       }
            //
            //                       for (test in categoriesArray) {
            //                         console.log('Categories info saved successfully.')
            //                         categoriesRef.child(categoriesArray[test]['id']).set(categoriesArray[test]);
            //                       }
            //                       if (episodeDict["show"] != null) {
            //                         if (episodeDict["show"]['categories'] != null) {
            //                           for (var category in shows[show]['_embedded']['categories']) {
            //                             categoryEpisodesRef.child(shows[show]['_embedded']['categories'][category]['id']).child(shows[show]['id']).set(episodeDict, function(error) {
            //                               if (error) {
            //                                 console.log("Data could not be saved." + error);
            //                               } else {
            //                                 console.log("category/offers/people data saved successfully.");
            //                                 rolesRef.child(rolesID).set(rolesDict, function(error) {
            //                                   if (error) {
            //                                     console.log("Data could not be saved." + error);
            //                                   } else {
            //                                     console.log("roles information saved successfully.");
            //                                     uploadCount++
            //                                     if (uploadCount == shows.length) {
            //                                       Shows.findOne({_id:showNumber}, function(err, show) {
            //                                         if (err) {
            //                                           console.log('error found')
            //                                           console.log('COMPLETE without posting show');
            //                                           function2();
            //                                           callback(true);
            //                                         }
            //                                         if (!show) {
            //                                           newShow.save(function(err) {
            //                                             if (err) {
            //                                               return console.log(err)
            //                                             } else {
            //                                             console.log('Show saved successfully to mongoDB!');
            //                                               if (shows[show]['_embedded']['shows'][embeddedShow]['active'] == true) {
            //                                                 activeShow.save(function(err) {
            //                                                   if (err) {
            //                                                     return console.log(err)
            //                                                   } else {
            //                                                   console.log('Active show saved successfully to mongoDB!');
            //                                                   console.log('COMPLETE');
            //                                                   function2();
            //                                                   callback(true);
            //                                                   }
            //                                                 });
            //                                               } else {
            //                                               console.log('COMPLETE');
            //                                               function2();
            //                                               callback(true);
            //                                               }
            //                                             console.log('COMPLETE');
            //                                             function2();
            //                                             callback(true);
            //                                             }
            //                                           });
            //                                         } else {
            //                                           console.log('Show is already in the database --> skipping upload');
            //                                           function2();
            //                                           callback(true);
            //                                         }
            //                                       });
            //                                     }
            //                                   }
            //                                 });
            //                               }
            //                             });
            //                           }
            //                         } else {
            //                               rolesRef.child(rolesID).set(rolesDict, function(error) {
            //                                 if (error) {
            //                                   console.log("Data could not be saved." + error);
            //                                 } else {
            //                                   console.log("roles information saved successfully.");
            //                                   console.log('COMPLETE');
            //                                   uploadCount++
            //                                   if (uploadCount == shows.length) {
            //                                     console.log('COMPLETE');
            //                                     function2();
            //                                     callback(true);
            //                                   }
            //                                 }
            //                               });
            //                             }
            //                       }
            //                     }
            //                   });
            //                 }
            //               }
            //             }
            //           });
            //         }
            //       });
            //     }
            //   });
          };

          console.log(uploadCount)
          console.log(shows.length)

          if (uploadCount == shows.length) {
            console.log('COMPLETE');
            function2();
            callback(true);
          }

          // console.log('COMPLETE');

      }, function (errorObject) {
        console.log("The read failed: " + errorObject.code);
      });

      function function2() {
       // app.delete();
        console.log('firebased closed');
      }


      //** Categories upload to mongoDB
      function uploadCategory(catDict, callback) {
        var catID = catDict['id']
        var labelRaw = catDict['label']
        var ttlRaw = catDict['ttl']
        var weightRaw = catDict['weight']
        var vidRaw = catDict['vid']
        var typeRaw = catDict['type']
        var vocabularyNameRaw = catDict['vocabularyName']
        var termPathRaw = catDict['termPath']
        var categorySchema = new Categories({
          _id: categoriesID,
          label: labelRaw,
          ttl: ttlRaw,
          weight: weightRaw,
          vid: vidRaw,
          type: typeRaw,
          vocabularyName: vocabularyNameRaw,
          termPath: termPathRaw
        })

        Categories.findOne({_id:catID}, function(err, cat) {
          if (err) {
            console.log('error found')
            console.log('COMPLETE without posting category');
            function2();
            callback(false);
          }
          if (!cat) {
            categorySchema.save(function(err) {
              if (err) {
                return console.log(err)
              } else {
              console.log('category saved successfully to mongoDB!');
              callback(true)
              }
            });
          } else {

            console.log('Show is already in the database --> skipping upload');
            function2();
            callback(false);
          }
        });
      }
}
module.exports.firebaseEpisodeSync = firebaseEpisodeSync;
module.exports.deletefirebase = deletefirebase;
