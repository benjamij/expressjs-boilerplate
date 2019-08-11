const express = require('express');
const passport = require('passport');
const uuidv4 = require('uuid/v4');

const MyModel = require('../models/mymodel');

const validators = require('../validators/mymodel');

const router = express.Router();

router.get('/',  passport.authenticate('jwt', {session: false}), async (req, res) => {
    // TODO: Do stuff here
    const messages = await Message.findAll(config);
    res.formatter.ok(messages);
});

router.post('/', validators.post, passport.authenticate('jwt', {session: false}), async (req, res) => {
    // TODO: Do stuff here or refactor
    let data = req.body;
    data.uuid = uuidv4();
    data.content = JSON.stringify(req.body.content);
    res.formatter.ok(await MyModel.create(data, {user: req.user}));
});

module.exports = router
