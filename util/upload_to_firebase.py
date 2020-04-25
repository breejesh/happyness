from firebase_admin import credentials, firestore, initialize_app
import csv

db = None

def init_firebase():
    global db
    cred = credentials.Certificate('./happyness-firebase.json')
    app = initialize_app(cred)
    db = firestore.client(app)

def upload_content_all():
    with open('news.csv') as file:
        csv_reader = csv.DictReader(file, quoting=csv.QUOTE_ALL, skipinitialspace=True)
        for row in csv_reader:
            news_json = dict(row)
            news_ref = db.collection('news')
            news_ref.document(news_json['id']).set(news_json)

def main():
    init_firebase()
    upload_content_all()

if __name__ == '__main__':
    main()