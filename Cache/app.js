const express = require('express')
const app = express()
const port = 8080

app.use(express.json())
app.use(express.static('public'))

app.get('/cache', (req, res) => {
  res.setHeader('Cache-Control', 'private, max-age=604800')
  res.sendFile('public/green.JPG', { root: __dirname })
})

app.get('/no-cache', (req, res) => {
  res.setHeader('Cache-Control', 'no-store')
  res.sendFile('public/green.JPG', { root: __dirname })
})

app.listen(port, () => {
  console.log(`host app listening on port ${port}`)
})
