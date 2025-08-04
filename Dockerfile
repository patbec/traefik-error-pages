FROM ghcr.io/patbec/pages-base:1.0.3

LABEL org.opencontainers.image.source=https://github.com/patbec/traefik-error-pages
LABEL org.opencontainers.image.description="Custom error pages for the Traefik reverse proxy."
LABEL org.opencontainers.image.licenses=MIT

COPY ./data /data