import os
import pyrebase


from firebase_admin import credentials

adminCredPath = 'cryptoapp-77770-firebase-adminsdk-e2di1-9f47cad4e0.json'

config_admin = {
    'apiKey': 'AlzaSyC50ogjcrl6CopcpQFQ9g5ePcSqJzc0ET8',
    'authDomain': 'cryptoapp-77770',
    'databaseURL': 'https://cryptoapp-77770.firebaseio.com',
    'storageBucket': 'cryptoapp-77770.appspot.com',
    'serviceAccount': adminCredPath
}


class cryptoApp():
    def __init__(self):
        self.firebase_app = pyrebase.initialize_app(config_admin)

    def database(self):
        db = self.firebase_app.database()
        return db


