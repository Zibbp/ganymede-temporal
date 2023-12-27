# Use a multi-stage build to build the binary for different platforms
FROM --platform=linux/amd64 alpine:latest AS amd64
RUN apk add --no-cache curl && \
  curl -L "https://temporal.download/cli/archive/latest?platform=linux&arch=amd64" -o /tmp/temporal_cli.tar.gz && \
  tar -xzf /tmp/temporal_cli.tar.gz -C /tmp && \
  mv /tmp/temporal /usr/local/bin/temporal && \
  chmod +x /usr/local/bin/temporal && \
  rm /tmp/temporal_cli.tar.gz

FROM --platform=linux/arm64 alpine:latest AS arm64
RUN apk add --no-cache curl && \
  curl -L "https://temporal.download/cli/archive/latest?platform=linux&arch=arm64" -o /tmp/temporal_cli.tar.gz && \
  tar -xzf /tmp/temporal_cli.tar.gz -C /tmp && \
  mv /tmp/temporal /usr/local/bin/temporal && \
  chmod +x /usr/local/bin/temporal && \
  rm /tmp/temporal_cli.tar.gz

# Create the final image
FROM alpine:latest
COPY --from=amd64 /usr/local/bin/temporal /usr/local/bin/temporal-amd64
COPY --from=arm64 /usr/local/bin/temporal /usr/local/bin/temporal-arm64
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
