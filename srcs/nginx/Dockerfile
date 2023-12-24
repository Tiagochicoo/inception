FROM nginx:stable-alpine

COPY default.conf /etc/nginx/conf.d/default.conf

# Copy the SSL certificates
COPY ./ssl/cert.crt /etc/ssl/certs/
COPY ./ssl/cert.key /etc/ssl/private/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
