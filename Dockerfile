FROM node:10.5.0-alpine as builder
#NOTE: Keep image used above in sync with what our CI runs tests in: \.circleci\config.yml
LABEL maintainer = "james.harrison.za@gmail.com"

WORKDIR /MyApplication

#Copy App and Build files
COPY . .

# Packages & dev dependancies
RUN npm ci

#Build bundle.js
RUN npm run build
RUN npm run browserify

# Release Image
FROM node:10.5.0-alpine

WORKDIR /MyApplication

# Copy release files only 
COPY --from=builder /MyApplication/public/bundle.js ./public/
COPY ./public ./public/
COPY ./index.html .
COPY ./favicon.ico .
COPY ./package.json .
COPY ./package-lock.json .
COPY ./server.js .

# Packages production only
ENV NODE_ENV production
RUN npm ci

EXPOSE 42420

CMD [ "npm", "start" ]