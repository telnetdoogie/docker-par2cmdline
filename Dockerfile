# Build Stage
ARG PAR2CMDLINE_VERSION=1.2.0
ARG TARGETARCH
ARG TARGETVARIANT

FROM alpine:3.21.3 as downloader
ARG PAR2CMDLINE_VERSION
ARG TARGETARCH
ARG TARGETVARIANT

RUN apk add --no-cache curl xz

# Download and extract the binary
RUN case "$TARGETARCH$TARGETVARIANT" in \
        "amd64") ARCH_SUFFIX="amd64" ;; \
        "arm64") ARCH_SUFFIX="arm64" ;; \
        "armv7") ARCH_SUFFIX="armhf" ;; \
        *) echo "Unsupported architecture: $TARGETARCH$TARGETVARIANT" && exit 1 ;; \
    esac && \
    curl -sSL "https://github.com/animetosho/par2cmdline-turbo/releases/download/v${PAR2CMDLINE_VERSION}/par2cmdline-turbo-v${PAR2CMDLINE_VERSION}-linux-${ARCH_SUFFIX}.xz" -o /tmp/par2cmdline-turbo.xz && \
    xz -d /tmp/par2cmdline-turbo.xz && \
    chmod +x /tmp/par2cmdline-turbo

# Final Stage
FROM alpine:3.21.3
COPY --from=downloader /tmp/par2cmdline-turbo /usr/bin/par2
RUN ln -s /usr/bin/par2 /usr/bin/par2create
RUN ln -s /usr/bin/par2 /usr/bin/par2repair
RUN ln -s /usr/bin/par2 /usr/bin/par2verify
COPY ./par.sh /
RUN chmod +x /par.sh
RUN mkdir -p /par2_files/
WORKDIR /par2_files
ENTRYPOINT ["/par.sh"]

