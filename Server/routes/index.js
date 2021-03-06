var express = require('express');
var router = express.Router();

var MainController = require('../controllers/main');

router.route('/twitdata/:uuid/mainpage')
  .get([MainController.index]);

router.route('/twitdata/:uuid/:showid/seasonpage')
    .get([MainController.seasons]);

/* GET home page. */
// router.get('/', function(req, res, next) {
//   res.render('index', { title: 'Express' });
// });

module.exports = router;
