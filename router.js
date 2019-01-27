const express = require('express')
var router = express.Router()
var bodyParser = require('body-parser')
var db = require('./db.js')
router.get('/', (req, res) => {
  res.send('Hello World')
})

const app = express()

// Use the body-parser middleware to make our data available in req.body
app.use(bodyParser.json())

// Use the router we defined in main_router.js for all requests at the root path
app.use('/', router)

app.listen(8080, () => {
  console.log('API is running')
})

router.get('/apple', async function(req, res) {
  try {
    let someData = await db.getData();
    res.send(someData);
  } catch (err) {
    console.error(err)
    res.send(err)
  }
})

module.exports=router;