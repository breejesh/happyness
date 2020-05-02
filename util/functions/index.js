const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

exports.new_news_notification = functions.firestore.document('news/{id}').onCreate((snapshot, context) => {
    var topic = 'new_news_notification';

    var news_id = context.params.news_id;
    var news_data = snapshot.data();
    console.log('latest news is: ', news_id, ' ', news_data.title);

    var payload = {
        notification: {
          title: 'Happyness is here!',
          body: news_data.title,
          sound: 'default',
          badge: '1',
          tag: 'news'
        },
    };

    return admin.messaging().sendToTopic(topic, payload)
    .then((response) => {
        // Response is a message ID string.
        // console.log('Successfully sent message:', response);
    })
    .catch((error) => {
        console.log('Error sending message:', error);
    });
});
