FROM node:4.4

RUN apt-get update && \
	apt-get install -y vim

COPY src /opt/app

RUN cd /opt/app; npm install

CMD ["node", "/opt/app/index.js"]

EXPOSE 6666