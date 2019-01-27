const express = require('express')
var router = express.Router()
var bodyParser = require('body-parser')
const url = require('url')
var request = require("request")
var db = require('./db.js')
const env = require('./.env')
require('dotenv').config()

const key = process.env.API_KEY;

router.get('/', (req, res) => {
  res.send('Hello World')
})

const app = express()

// Use the body-parser middleware to make our data available in req.body
app.use(bodyParser.json())

// Use the router we defined in main_router.js for all requests at the root path
app.use('/', router)

app.listen(3000, () => {
  console.log('API is running')
})

router.get('/data', async function(req, res) {
  try {
    let someData = await db.getData();
    res.send(someData);
  } catch (err) {
    console.error(err)
    res.send(err)
  }
})



router.get('/recipies', async function(req, res){
  try{
    let data = await db.getData();
    q='butter'
    for(i = 3; i< 9; i++){
      if(data[i]['value']>=25){
        q=q+','+String(data[i]['id2'])
      }
    }
    console.log(q)
    request({
      url: `https://www.food2fork.com/api/search?key=${key}&q=${q}`,
      json: true
  }, function (error, response, body) {
  
      if (!error && response.statusCode === 200) {
          res.send(body)
          
          // Print the json response
      }
  })
    // let recipies = JSON.parse(`https://www.food2fork.com/api/search?key=${key}&q=chicken%20breast&page=2`);
    // console.log(recipies)
  } catch(err){
    console.log(err)
    res.send(err)
  }
})

module.exports=router;