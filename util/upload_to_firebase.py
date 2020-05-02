from firebase_admin import credentials, firestore, initialize_app
import csv
import time
import hashlib

db = None

def init_firebase():
    global db
    cred = credentials.Certificate('./happyness-python-firebase.json')
    app = initialize_app(cred)
    db = firestore.client(app)

def upload_content_all():
    with open('news.csv') as file:
        csv_reader = csv.DictReader(file, quoting=csv.QUOTE_ALL, skipinitialspace=True)
        ts = int(time.time())
        for row in csv_reader:
            news_json = dict(row)
            # id = hashlib.md5(news_json['title'].encode()).hexdigest()
            ts = ts + 1
            news_ref = db.collection('news')
            news_ref.document(str(ts)).set(news_json)


def main():
    init_firebase()
    upload_content_all()

if __name__ == '__main__':
    main()