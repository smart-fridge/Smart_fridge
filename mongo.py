import pymongo

client = pymongo.MongoClient("mongodb://tamuhack:tamuhack@cluster0-shard-00-00-stavr.gcp.mongodb.net:27017,cluster0-shard-00-01-stavr.gcp.mongodb.net:27017,cluster0-shard-00-02-stavr.gcp.mongodb.net:27017/test?ssl=true&replicaSet=Cluster0-shard-0&authSource=admin&retryWrites=true")
db = client["tamuhack"]
mycollection = db["tamuhack"]

mydict = { "id": "xyz", "address": "Highway 95620" }

db.sma.update({"id": "xyz"},mydict, upsert= True)

# x = collection.insert_one(mydict)