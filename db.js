var MongoClient = require('mongodb').MongoClient;

const options = { useNewUrlParser: true }

const env = require('./.env')
require('dotenv').config()

const password = process.env.PASSWORD;

var uri = `mongodb://tamuhack:${password}@cluster0-shard-00-00-stavr.gcp.mongodb.net:27017,cluster0-shard-00-01-stavr.gcp.mongodb.net:27017,cluster0-shard-00-02-stavr.gcp.mongodb.net:27017/test?ssl=true&replicaSet=Cluster0-shard-0&authSource=admin&retryWrites=true`;
MongoClient.connect(uri, function(err, db) {
   const collection = db.db("tamuhack").collection("smartfridge");
   if (err) throw err;
  var dbo = db.db("tamuhack");
  dbo.collection("smartfridge").find({'id': 'data'}, {projection:{_id:0, id2:1, value:1}}).toArray(function(err, result) {
    if (err) throw err;
    console.log(result);
  });
  db.close();
});

async function getData () {
  let db
  try {
    db = await MongoClient.connect(uri, options);
    const collection = db.db("tamuhack").collection("smartfridge");
    const results = await collection.find({'id': 'data'},  {projection:{_id:0, id2:1, value:1}} ).toArray()
    return results
    db.close()
  } catch (err) {
      console.error(err)
  }
}

module.exports = {getData}