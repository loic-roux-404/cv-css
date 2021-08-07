FROM node:alpine as builder

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

ADD package*.json ./

RUN npm set progress=false
RUN npm install --only=production
ADD . .
RUN npm run-script build

FROM nginx:alpine
COPY nginx.default.conf /etc/nginx/conf.d/default.conf
WORKDIR /usr/share/nginx/html
COPY --from=builder /loic .

EXPOSE 80
