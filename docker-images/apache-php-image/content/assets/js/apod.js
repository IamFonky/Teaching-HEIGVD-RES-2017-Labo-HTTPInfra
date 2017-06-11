$(function() {
	console.log("Loading APODs");

	function loadAPOD() {
		$.getJSON( "/api/apod/", function ( apod ) {
			console.log(apod);
			var title = apod.title;
			var src = apod.image;
			$(".apodImage").attr('src', src);
			setTimeout(function(){
			  $(".apodTitle").text(title);
			}, 2000);
		});
	};

	loadAPOD();
	setInterval( loadAPOD, 7000 );
});