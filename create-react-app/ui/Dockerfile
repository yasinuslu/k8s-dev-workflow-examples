FROM node:10-alpine as dev

WORKDIR /app

# needed to run development server
RUN apk add --update util-linux git python make bash g++ tzdata

# only copy files needed for installing dependencies
COPY package.json yarn.lock /app/

# install all modules
RUN yarn install --frozen-lockfile

# copy source
COPY . /app

ENV PORT=80

CMD ["yarn", "start"]

# starting point for builder image
FROM node:10-alpine as builder

WORKDIR /app

# get source and all node_modules from dev stage
COPY --from=dev /app /app

RUN yarn build

# starting point for production image
FROM nginx:alpine as prod

# get generated files from builder
COPY --from=builder /app/build /usr/share/nginx/html
