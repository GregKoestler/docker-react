#Multi-step docker build example. Build app with node then setup a simple web server with nginx
#Build phase
FROM node:alpine

WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .

RUN npm run build

#Setup ngnx phase
FROM nginx

#Copy build dir from the last phase
COPY --from=0 /app/build /usr/share/nginx/html

#nginx starts up automatically, no need to run a run command here