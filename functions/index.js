// Cloud Functions (squelette) - Node 20
// npm i firebase-admin firebase-functions
const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.hello = functions.https.onRequest(async (req, res) => {
  res.json({ ok: true, msg: 'Carnet backend up' });
});

// TODO: Implement scheduled reminders + eraseUserData as per plan technique.
