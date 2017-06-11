FROM node:4.4

RUN apt-get update && \
	apt-get install -y vim

COPY src /opt/app

RUN cd /opt/app; npm install

EXPOSE 6666

CMD ["node", "/opt/app/index.js"]