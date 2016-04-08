FROM mhart/alpine-node:4
ADD ./package.json ./
ADD ./app.js ./

RUN npm install

CMD ["node", "app.js"]

