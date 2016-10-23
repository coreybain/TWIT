var mongoose = require('mongoose');

var Schema = mongoose.Schema;

var categoriesSchema = new Schema({
  _id: Number,
      id: String,
      label: String,
      ttl: String,
      weight: String,
      vid: String,
      type: String,
      vocabularyName: String,
      termPath: String
}, { strict: false });

var Categories = mongoose.model('CategoriesSchema', categoriesSchema);

module.exports = Categories;
