FROM node:14-alpine as builder

WORKDIR /usr/app

COPY ./package.json .
COPY ./package-lock.json .

RUN npm install

COPY . .

RUN apk add --no-cache git

RUN npm run build

# ##########################

FROM nginx

COPY --from=builder /usr/app/build /usr/share/nginx/html

