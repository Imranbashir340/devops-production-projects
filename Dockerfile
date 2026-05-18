# Use a stable, lightweight Nginx base image
FROM nginx:1.25-alpine

# Set metadata labels using the Open Container Initiative (OCI) standard
LABEL org.opencontainers.image.title="DevOps Mission Control Dashboard" \
      org.opencontainers.image.description="Interactive, real-time DevOps project dashboard demonstrating GitHub Actions CI/CD pipelines, Docker containerization, and Nginx hosting." \
      org.opencontainers.image.authors="Imran Bashir <https://github.com/Imranbashir340>" \
      org.opencontainers.image.source="https://github.com/Imranbashir340/devops-production-projects" \
      org.opencontainers.image.version="1.1.0" \
      org.opencontainers.image.licenses="MIT"

# Copy the premium index.html to Nginx web root
COPY index.html /usr/share/nginx/html/index.html

# Set secure permissions for static assets
RUN chmod 644 /usr/share/nginx/html/index.html

# Expose port 80 for HTTP traffic
EXPOSE 80

# Configure a robust runtime healthcheck to monitor webserver availability
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost/ || exit 1

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]