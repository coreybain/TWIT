var mongoose = require('mongoose');

var Schema = mongoose.Schema;

var allEpisodesSchema = new Schema({
  _id: Number,
  info: {},
  show: {
    credits: {
      Number: {
        id:Number,
        label:String,
        ttl:Number,
        roles: {
          id:Number,
          label:String,
          ttl:Number,
          weight:Number,
          vid:Number,
          type:String,
          vocabularyName:String,
          termPath:String
        }
      }
    },
    categories: {
      id: {
        id:Number,
        label:String,
        ttl:Number,
        weight:Number,
        vid:Number,
        type:String,
        vocabularyName:String,
        termPath:String
      }
    }
  }
}, { strict: false });

var AllEpisodes = mongoose.model('AllEpisodes', allEpisodesSchema);

module.exports = AllEpisodes;
