var express = require('express');
var router = express.Router();

marketingglobal = 0;
router.get('/', function(req, res, next) {
  var htmlvar = {
    response: "Response OK"
  };  
  marketingglobal++;
  var marketingmath = marketingglobal%2;
  var marketingresult = parseInt(marketingmath);

  if (marketingresult == 0) {
    res.status(200).send(htmlvar);
  }
  else{
    res.status(500).send();
  }
});

module.exports = router;