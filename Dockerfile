# Stage: Lightweight runtime based on Nginx Alpine
FROM nginx:alpine

# Metadata
LABEL maintainer="musyaffa-iman"
LABEL description="Dummy gNB workload for O-RAN O2 Testing Framework Milestone 1"

# Copy the static dummy gNB landing page to Nginx default document root
COPY index.html /usr/share/nginx/html/index.html

# Expose standard HTTP port
EXPOSE 80

# Healthcheck to verify the web service is responsive
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:80/ || exit 1

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
