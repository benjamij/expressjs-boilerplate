const db = require('../../core/db/db');
const Sequelize = require('sequelize');

// Sample modelw with sample fields
const MyModel = db.define('mymodel', {
    uuid: Sequelize.STRING,
    from: Sequelize.STRING,
    to: Sequelize.STRING,
    is_read_by_admin: Sequelize.BOOLEAN,
    session_id: Sequelize.STRING,
    agent_uuid: Sequelize.STRING,
    content: Sequelize.TEXT
});

MyModel.sync();

module.exports = Message;
