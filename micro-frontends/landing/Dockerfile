FROM node:10-alpine as dev

ARG TZ="Etc/GMT"

ENV TZ ${TZ}

WORKDIR /app

COPY package.json yarn.lock /app/

RUN apk add --update util-linux git python make bash g++ tzdata

RUN yarn install --frozen-lockfile

COPY . /app

CMD ["yarn", "dev"]

# starting point for production image
FROM node:10-alpine as prod

WORKDIR /app

COPY --from=dev /app /app

RUN yarn build

CMD ["yarn", "start"]
