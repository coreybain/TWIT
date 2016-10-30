var mongoose = require('mongoose');

var Shows = require('../Schemas/showsSchema');
var ActiveShows = require('../Schemas/activeShowSchema');
var Categories = require('../Schemas/categorySchema');
var Episodes = require('../Schemas/episodesSchema');
var AllEpisodes = require('../Schemas/allEpisodesSchema');
var People = require('../Schemas/peopleSchema');

mongoose.createConnection('mongodb://localhost/TwitTest');
var json = {};
var activeShows = [];
var pastShows = [];
var newCounter = 0;
var trendingCounter = 0;

exports.index = function(req, res, next) {
  AllEpisodes.find().sort({'_id': -1}).limit(20).exec(function(err, allepisodes) {
    json.allepisodes = allepisodes
    Shows.find().sort({'_id': -1}).exec(function(err, shows) {
      for (show in shows) {
        if (shows[show]['info']['active'] == true) {
          activeShows.push(shows[show])
        } else {
          pastShows.push(shows[show])
        }
      }
      json.activeShows = activeShows
      json.pastShows = pastShows
      People.find().sort({'_id': +1}).limit(20).exec(function(err, people) {
        json.people = people
            AllEpisodes.find({'show.categories.93.id': '93'}).sort({'_id': -1}).limit(20).exec(function(err, newsCat) {
              json.newsCat = newsCat;
              AllEpisodes.find({'show.categories.92.id': '92'}).sort({'_id': -1}).limit(20).exec(function(err, reviewCat) {
                json.reviewCat = reviewCat;
                AllEpisodes.find({'show.categories.2001.id': '2001'}).sort({'_id': -1}).limit(20).exec(function(err, bitCat) {
                  json.bitCat = bitCat;
                  AllEpisodes.find({'show.categories.94.id': '94'}).sort({'_id': -1}).limit(20).exec(function(err, howCat) {
                    json.howCat = howCat;
                    res.json(json)
                  });
                });
              });
        });
      });

  });
});
  //res.json(AllEpisodes);
}

var newEppDict = [];
var trendingDict = [];

exports.seasons = function(req, res, next) {
  console.log(req.params.showid);
  Episodes.find({'_id': req.params.showid}).sort({'_id': -1}).exec(function(err, newEpisodes) {
    for (var episode in newEpisodes) {
      var trending = newEpisodes[episode]['allEpisodes']
      var sorted = trending.sort(function(a, b) {
        var alpha = 0
        var beta = 0
        for(var key in a) {
          alpha = key
        }
        for(var key in b) {
          beta = key
        }
        return beta - alpha;
      });
      json.newEpisodes = sorted.slice(0, 16);
    }
    Episodes.find({'_id': req.params.showid}).sort().exec(function(err, trendingEpisodes) {
      for (var episode in trendingEpisodes) {
        var trend = trendingEpisodes[episode]['allEpisodes'];
        json.trendingEpisodes = trend.slice(0, 16);

      }
      res.json(json)
    })
  })
  //res.json(AllEpisodes);
}
