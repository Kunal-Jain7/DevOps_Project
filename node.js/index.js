var express = require('express')
const process = require('process');

var expressapp = express()
expressapp.get('/', function (req, res) {
    res.send('{"message":"Hello World !! This message is from node.js Docker container !!}')
})
expressapp.listen(5002, function () {
    console.log('Ready on 5002!!')
})
process.on('SIGINT', function (){
    process.exit();
})