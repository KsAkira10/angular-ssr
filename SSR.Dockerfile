FROM node:alpine as buildContainer
WORKDIR /ng-app
COPY package.json package-lock.json neon-pagamentos-neon-components-0.13.3.tgz /ng-app/
RUN npm config set //registry.npmjs.org/:_authToken=674cce43-1b92-45be-8576-bb42bd5fcf8d
RUN npm i npm@latest -g
RUN npm set progress=false
RUN npm cache clear --force
RUN npm i
COPY ./ /ng-app/
ARG env=production
RUN npm run build:ssr

FROM node:alpine

WORKDIR /ng-app
# Copy dependency definitions
COPY --from=buildContainer /ng-app/package.json /ng-app

# Get all the code needed to run the app
COPY --from=buildContainer /ng-app/dist /ng-app/dist

# Expose the port the app runs in
EXPOSE 4000

# Serve the app
CMD ["npm", "run", "serve:ssr"]
