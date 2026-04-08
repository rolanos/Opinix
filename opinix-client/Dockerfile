FROM node:18
WORKDIR /app
COPY opinix-client/package.json ./
RUN npm install
RUN npm install axios react-router-dom
COPY opinix-client/. .
RUN npm run build
CMD ["npm", "start"]
