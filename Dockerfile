# Build Stage
ARG PAR2CMDLINE_VERSION=1.3.0
ARG TARGETARCH
ARG TARGETVARIANT

FROM alpine:3.23.2 AS downloader
ARG PAR2CMDLINE_VERSION
ARG TARGETARCH
ARG TARGETVARIANT

# update base image for vulns
RUN apk update && apk upgrade --no-cache
RUN apk add --no-cache curl unzip

# Download and extract the binary
RUN case "$TARGETARCH$TARGETVARIANT" in \
        "amd64") ARCH_SUFFIX="amd64" ;; \
        "arm64") ARCH_SUFFIX="arm64" ;; \
        "armv7") ARCH_SUFFIX="armhf" ;; \
        *) echo "Unsupported architecture: $TARGETARCH$TARGETVARIANT" && exit 1 ;; \
    esac && \
    curl -sSL "https://github.com/animetosho/par2cmdline-turbo/releases/download/v${PAR2CMDLINE_VERSION}/par2cmdline-turbo-${PAR2CMDLINE_VERSION}-linux-${ARCH_SUFFIX}.zip" -o /tmp/par2cmdline-turbo.zip && \
    unzip /tmp/par2cmdline-turbo.zip -d /tmp/ && \
    chmod +x /tmp/par2


# Final Stage
FROM alpine:3.23.2

# update base image for vulns
RUN apk update && apk upgrade --no-cache

COPY --from=downloader /tmp/par2 /usr/bin/par2
RUN ln -s /usr/bin/par2 /usr/bin/par2create
RUN ln -s /usr/bin/par2 /usr/bin/par2repair
RUN ln -s /usr/bin/par2 /usr/bin/par2verify
COPY ./par.sh /
RUN chmod +x /par.sh
RUN mkdir -p /par2_files/
WORKDIR /par2_files
ENTRYPOINT ["/par.sh"]

