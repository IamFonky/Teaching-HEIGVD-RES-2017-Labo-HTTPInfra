# Teaching-HEIGVD-RES-2017-Labo-HTTPInfra
Labo de l'année en RES!

**Etape 1**  
Il s'agit tout d'abord de créer un container docker afin de contenir le serveur HTTP.
Une image est créée dans docker-images/apache-php-image/ . Le fichier Dockerfile va copier le dossier contenant le site web directement dans le repertoire web du serveur http.  

**Dockerfile :**

	FROM php:5.6-apache

	COPY content/ /var/www/html/

Le but ensuite est de build l'image et lancer un nouveau conteneur :

	docker build -t res/apache-php ../apache-php-image
	docker run --name apache_static -p 9090:80 res/apache-php

Il est ensuite possible d'accéder au site web via localhost:9090.

Commit : #c2e9f76e3649a268cb0ee2045037f52fa8a872c0  
  

**Etape 2**  
Pour cette étape, nous allons créer un conteneur docker allant exécuter un serveur HTML via la libraire **express**.

Premièrement, il faut créer une image docker exécutant **node.js** et en copiant le contenu du répertoire *src* dans le dossier */opt/app* dans le conteneur. Puis, on va exécuter l'installation des modules *npm* et enfin lancer l'application *index.js* afin qu'on puisse y avoir accès dès que le conteneur est lancé.

**Dockerfile :**

	FROM node:4.4

	COPY src /opt/app

	RUN cd /opt/app; npm install

	CMD ["node", "/opt/app/index.js"]

Pour réaliser notre application dynamique, nous allons utiliser les modules npm *express* (permettant, entre autre, d'exécuter un serveur HTTP) et *random-apod* (fournissant de manière aléatoire un objet JSON représentant une photo astronomique aléatoire).

Premièrement, il faut générer le fichier **package.json**, puis ajouter des dépendences.

**Dépendances package.json :**

	"dependencies": {
		"chance": "^1.0.9",
		"express": "^4.15.3",
		"random-apod": "^1.0.1"
	}

Ensuite, nous allons réaliser l'application permettant d'envoyer un object JSON dynamiquement.

**index.js :**

	var express = require('express');
	var app = express();

	var randomApod = require('random-apod');

	app.get('/', function(req, res) {
		res.send(randomApod());
	});

	app.listen(6666, function() {
		console.log('Acception HTTP requests on port 6666.');
	});

Ensuite, il faut build l'image docker et lancer le conteneur :

	docker build -t res/express ../express-image
	docker run --name express_dynamic -p 9090:6666 res/express

Ensuite, on accède via un navigateur à l'adresse *localhost:9090*.

**Exemple de JSON :**

	{
	 	"id": "http://apod.nasa.gov/apod/ap950627.html",
	 	"title": "An Ultraviolet Image of M101",
	 	"image": "http://apod.nasa.gov/apod/image/uitm101.gif"
	}

Commit : #5d63af38aefc5d415a0765c7fb29e5e11180f66c

**Etape 3**  
A cette étape nous configurons le serveur apache pour qu'il fonctionne comme reverse proxy.
Pour ceci nous allons ajouter des sites en ajoutant des modules au fichier httpd.conf.
Le fichier 001-default.conf est créé grace au script step3.sh. Il
récupére les adresse ip des deux serveurs et écris les règles pour chacun d'eux.


Commit : #...

**Etape 4**
Dans cette quatrième étape, nous allons utilisé l'infrastructure mise en place lors de points précédents afin de réaliser une page web mettant certains composants automatiquement à jour sans que celle-ci ne soit rechargée.

Un script utilisant AJAX et jQuery va récupérer les données envoyées par **express** et modifier une balise de texte et une image sur la page web en y ajoutant les valeurs prises dans le JSON. Les valeurs sont modifiées toutes les 7 secondes.

**apod.js :**

	$(function() {
		console.log("Loading APODs");

		function loadAPOD() {
			$.getJSON( "/api/students/", function ( apod ) {
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

Remarque : on voit que lorsque l'image est modifiée, on va attendre un petit délai avant d'afficher le titre. En effet, on va laisser le temps à l'image de charger.

Commit : #