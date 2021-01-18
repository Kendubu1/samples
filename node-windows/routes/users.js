var express = require('express');
var router = express.Router();

function generateid (userID) {
  const numbers = userID / 8;
  const arr = []
  arr.length = numbers;
  for (let i = 0; i < numbers; i++) {
      arr[i] = i;
  }
  return arr;
};

var userslist = [];
router.get('/', function(req, res, next) {
  let userID = 200000 * 1024;

  const user = generateid(userID);
  userslist.push(user);

  var htmlvar = {
    response: "User Added Num: " + Math.floor(Math.random() * 20) + 1
  };
  
  res.status(200).send(htmlvar);
});

module.exports = router;
