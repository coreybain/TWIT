var mongoose = require('mongoose');

var Schema = mongoose.Schema;

var peopleSchema = new Schema({
  _id: Number,
  info: {
    id: { type: Number , unique: true },
    label: { type: String },
    ttl: String,
    description: String,
    showDate: String,
    showContactInfo: String,
    tagLine: String,
    shortCode: String,
    active: Boolean,
    weight: String,
    heroImage: {
      fid: { type: String , unique: true },
      url: { type: String },
      fileName: String,
      urmineTypel: String,
      fileSize: String,
      width: String,
      height: String,
      status: String,
      derivatives: {
        thumbnail: String,
        twit_slideshow_1600x400: String,
        twit_slideshow_1200x300: String,
        twit_slideshow_800x200: String,
        twit_slideshow_600x450: String,
        twit_slideshow_400x300: String
      }
    }
  }
}, { strict: false });

var People = mongoose.model('People', peopleSchema);

module.exports = People;
