FROM node:10-alpine as buildContainer
WORKDIR /ng-app
COPY ./package.json ./package-lock.json /ng-app/
RUN npm install
COPY . /ng-app
RUN npm run build:ssr

FROM node:8-alpine

WORKDIR /ng-app
# Copy dependency definitions
COPY --from=buildContainer /ng-app/package.json /ng-app
COPY --from=buildContainer /ng-app/server.js /ng-app

# Get all the code needed to run the app
COPY --from=buildContainer /ng-app/dist /ng-app/dist
COPY --from=buildContainer /ng-app/static /ng-app/static
COPY --from=buildContainer /ng-app/dist-server /ng-app/dist-server

# Expose the port the app runs in
EXPOSE 4000

# Serve the app
CMD ["npm", "run", "server:ssr"]
