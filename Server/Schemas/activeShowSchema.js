var mongoose = require('mongoose');

var Schema = mongoose.Schema;

var activeShowSchema = new Schema({
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
    },
    coverArt: {
      fid: { type: String , unique: true },
      url: { type: String },
      fileName: String,
      urmimeTypel: String,
      fileSize: String,
      width: String,
      height: String,
      status: String,
      derivatives: {
        thumbnail: String,
        twit_album_art_70x70: String,
        twit_album_art_144x144: String,
        twit_album_art_240x240: String,
        twit_album_art_300x300: String,
        twit_album_art_600x600: String,
        twit_album_art_1400x1400: String,
        twit_album_art_2048x2048: String
      }
    },
    hdVideoSubscriptionOption: {
      id: Schema.Types.Mixed,
      label: Schema.Types.Mixed,
      ttl: Schema.Types.Mixed,
      url: Schema.Types.Mixed,
      type: Schema.Types.Mixed,
      sticky: Schema.Types.Mixed,
      feedProvider: {
        id: Schema.Types.Mixed,
        label: Schema.Types.Mixed,
        ttl: Schema.Types.Mixed,
        active: Schema.Types.Mixed
      }
    },
    sdVideoSmallSubscriptionOptions: {
      id: Schema.Types.Mixed,
      label: Schema.Types.Mixed,
      ttl: Schema.Types.Mixed,
      url: Schema.Types.Mixed,
      type: Schema.Types.Mixed,
      sticky: Schema.Types.Mixed,
      feedProvider: {
        id: Schema.Types.Mixed,
        label: Schema.Types.Mixed,
        ttl: Schema.Types.Mixed,
        active: Schema.Types.Mixed
      }
    },
    audioSubscriptionOptions: {
        id: Schema.Types.Mixed,
        label: Schema.Types.Mixed,
        ttl: Schema.Types.Mixed,
        url: Schema.Types.Mixed,
        type: Schema.Types.Mixed,
        sticky: Schema.Types.Mixed,
        feedProvider: {
          id: Schema.Types.Mixed,
          label: Schema.Types.Mixed,
          ttl: Schema.Types.Mixed,
          active: Schema.Types.Mixed
        }
    }
  },
  topics: {
    Number: {
      id: String,
      label: String,
      ttl: String,
      weight: String,
      vid: String,
      type: String,
      vocabularyName: String,
      termPath: String
    }
  },
  categories: {
    Number: {
      id: String,
      label: String,
      ttl: String,
      weight: String,
      vid: String,
      type: String,
      vocabularyName: String,
      termPath: String
    }
  },
  people: {
      id: String,
      label: String,
      ttl: String,
      bio: String,
      bioSummary: String,
      published: String,
      sticky: String,
      staff: String,
      picture: {
        fid: String,
        url: String,
        fileName: String,
        mimeType: String,
        fileSize: String,
        width: String,
        height: String,
        status: String,
        derivatives: {
          thumbnail: String,
          twit_album_art_70x70: String,
          twit_album_art_144x144: String,
          twit_album_art_240x240: String,
          twit_album_art_300x300: String,
          twit_album_art_600x600: String,
          twit_album_art_1400x1400: String,
          twit_album_art_2048x2048: String
        },
    relatedLinks: {
        title: String,
        url: String
      }
    }
  }
}, { strict: false });

var Show = mongoose.model('ActiveShow', activeShowSchema);

module.exports = Show;
