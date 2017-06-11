# Teaching-HEIGVD-RES-2017-Labo-HTTPInfra
Labo de l'année en RES!

**Etape 1**  
Il s'agit tout d'abord de créer un container docker afin de contenir le serveur HTTP.
Une image est créée dans docker-images/apache-php-image/ . Le fichier Dockerfile va copier le dossier contenant le site web directement dans le repertoire web du serveur http.  

Commit : #c2e9f76e3649a268cb0ee2045037f52fa8a872c0  
  

**Etape 2**  
...  
Commit : #...  

**Etape 3**  
A cette étape nous configurons le serveur apache pour qu'il fonctionne comme reverse proxy.
Pour ceci nous allons ajouter des sites en ajoutant des modules au fichier httpd.conf.
Le fichier 001-default.conf est créé grace au script step3.sh. Il
récupére les adresse ip des deux serveurs et écris les règles pour chacun d'eux.


Commit : #...