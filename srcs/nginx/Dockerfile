FROM nginx:stable-alpine

COPY ./srcs/nginx/default.conf /etc/nginx/conf.d/default.conf

# Copy the SSL certificates
COPY ./srcs/nginx/cert.crt /etc/ssl/certs/
COPY ./srcs/nginx/cert.key /etc/ssl/private/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
