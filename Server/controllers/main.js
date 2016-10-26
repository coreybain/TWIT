var mongoose = require('mongoose');

var Shows = require('../Schemas/showsSchema');
var ActiveShows = require('../Schemas/activeShowSchema');
var Categories = require('../Schemas/categorySchema');
var Episodes = require('../Schemas/episodesSchema');
var AllEpisodes = require('../Schemas/allEpisodesSchema');
var People = require('../Schemas/peopleSchema');

mongoose.createConnection('mongodb://localhost/TwitTest');
var json = {};

exports.index = function(req, res, next) {
  AllEpisodes.find().sort({'_id': -1}).limit(20).exec(function(err, allepisodes) {
    json.allepisodes = allepisodes
    Shows.find().sort({'_id': -1}).limit(20).exec(function(err, shows) {
      json.shows = shows
      People.find().sort({'_id': +1}).limit(20).exec(function(err, people) {
        json.people = people
        Episodes.find({'_id': '1683'}).exec(function(err, allBits) {
          console.log(allBits.length);
          for (var bit in allBits) {
            json.bit = allBits[bit]['allEpisodes'];
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
          }
        });
      });

  });
});
  //res.json(AllEpisodes);
}
