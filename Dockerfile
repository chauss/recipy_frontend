FROM nginx:1.21.1-alpine
COPY ./build/web /usr/share/nginx/html