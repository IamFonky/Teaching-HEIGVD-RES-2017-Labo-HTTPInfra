var Chance = require('chance');
var chance = new Chance();

var express = require('express');
var app = express();

app.get('/', function(req, res) {
	res.send(generateStudent());
});

app.listen(6666, function() {
	console.log('Acception HTTP requests on port 6666.');
});

function generateStudent() {
	var numberOfStudents = chance.integer({
		min: 0,
		max:10
	});
	var studentList = [];
	for (var i = 0; i < numberOfStudents; i++) {
		var sexe = chance.gender();
		var birthYear = chance.year({
			min: 1990,
			max: 1999
		});
		studentList.push({
			firstName: chance.first({
				genre: sexe,
				nationality: "it"
			}),
			lastName: chance.last({
				nationality: "it"
			}),
			sexe: sexe,
			birthday: chance.birthday({
				year: birthYear
			})
		});
	}
	return studentList;
}