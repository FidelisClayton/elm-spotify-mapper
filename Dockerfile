FROM node:10

# Receive the npm token from args to be able to setup the private registry
# ARG NPM_TOKEN

# Setup the private npm registry
# RUN npm config set @dentalux:registry https://gitlab.com/api/v4/packages/npm/
# RUN npm config set -- '//gitlab.com/api/v4/packages/npm/:_authToken' "${NPM_TOKEN}"

WORKDIR /app

COPY package.json package-lock.json /app/

RUN npm install

COPY . ./

CMD npm start
