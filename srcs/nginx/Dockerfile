FROM alpine

# Install NGINX
RUN apk update && apk add nginx

# Copy NGINX configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 443
EXPOSE 443

# Set NGINX as the entry point
CMD ["nginx", "-g", "daemon off;"]
