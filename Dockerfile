FROM nginx:1.21.1-alpine

RUN mkdir /usr/share/nginx/html/tools
RUN mkdir /usr/share/nginx/html/config

VOLUME /usr/share/nginx/html/config
VOLUME /var/log/nginx/

COPY ./conf/default.conf /etc/nginx/conf.d/default.conf
COPY ./configs/health.json /usr/share/nginx/html/tools/health.json

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
