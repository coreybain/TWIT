var mongoose = require('mongoose');

var Schema = mongoose.Schema;

var episodesSchema = new Schema({
  _id: Number, 
  allEpisodes: [
    {  }, { strict: false }
]
}, { strict: false });

var Episodes = mongoose.model('Episodes', episodesSchema);

module.exports = Episodes;
