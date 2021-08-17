FROM nginx:1.21.1-alpine

VOLUME /usr/share/nginx/html/

COPY ./conf/nginx/pagelist.conf /etc/nginx/conf.d/default.conf
# COPY ./conf/pagelist.sample.json /usr/share/nginx/html/pagelist.json

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
