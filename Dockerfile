FROM nginx:1.21.1-alpine
COPY ./build/web /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/nginx.conf
RUN rm /etc/nginx/conf.d/default.conf
RUN nginx -s reload