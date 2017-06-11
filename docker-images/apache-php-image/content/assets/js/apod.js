$(function() {
	console.log("Loading APODs");

	function loadAPOD() {
		$.getJSON( "/api/apod/", function ( apod ) {
			console.log(apod);
			var title = apod.title;
			var src = apod.image;
			$(".apodTitle").text(title);
			$(".apodImage").attr('src', src);
		});
	}
});

loadAPOD();
setInterval( loadAPOD, 2000 );