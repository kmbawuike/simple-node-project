# import node
FROM node:20-alpine

# Create directory
RUN mkdir -p /home/app

# copy files
COPY ./app /home/app

#set working directory
WORKDIR /home/app

#install dependencies
RUN npm install

EXPOSE 3000

#start application 
CMD ["node", "server.js"]