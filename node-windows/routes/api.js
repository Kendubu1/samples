var express = require('express');
var router = express.Router();

router.use('/users', require('./users'));
router.use('/marketing', require('./marketing'));
router.use('/reports', require('./reports'));
router.use('/admin', require('./admin'));

module.exports = router;
