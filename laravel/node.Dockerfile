FROM node:10.16-alpine AS front
WORKDIR /code
COPY package.json package-lock.json /code/
RUN npm install --quiet

COPY webpack.mix.js /code
COPY ./resources/ /code/resources/

FROM front AS front-dev
RUN npm run dev

FROM front AS front-prod
RUN npm run prod
