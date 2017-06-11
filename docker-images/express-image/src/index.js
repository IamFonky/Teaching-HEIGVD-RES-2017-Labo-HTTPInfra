var express = require('express');
var app = express();

var randomApod = require('random-apod');

app.get('/', function(req, res) {
	res.send(randomApod());
});

app.listen(6666, function() {
	console.log('Acception HTTP requests on port 6666.');
});
