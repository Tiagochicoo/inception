# Use the official Nginx image as a base
FROM nginx:1.24.0-alpine-slim

# Copy your custom Nginx configuration file into the container
COPY ./default.conf /etc/nginx/nginx.conf

# Copy your SSL certificate and key into the container
COPY ./ssl/nginx-selfsigned.crt /etc/nginx/certs/
COPY ./ssl/nginx-selfsigned.key /etc/nginx/certs/

# Expose port 443 for SSL traffic
EXPOSE 443

# Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]
