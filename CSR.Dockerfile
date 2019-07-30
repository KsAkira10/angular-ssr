# STAGE 1 - Build ng-app
FROM node:alpine as node
WORKDIR /ng-app
COPY package.json package-lock.json /ng-app/
RUN npm config set //registry.npmjs.org/:_authToken=674cce43-1b92-45be-8576-bb42bd5fcf8d
RUN npm i npm@latest -g
RUN npm set progress=false
RUN npm cache clear --force
RUN npm i
COPY ./ /ng-app/
ARG env=production
RUN npm run build -- --prod

# STAGE 2 - Expose ng-app
FROM nginx:alpine
COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf
RUN rm -rf /usr/share/nginx/html/*
COPY --from=node /ng-app/dist/neon-ssr /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
