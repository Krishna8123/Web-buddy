# Use official nginx image
FROM nginx:alpine

# Copy your HTML file into nginx's default web directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# nginx starts automatically as entrypoint
