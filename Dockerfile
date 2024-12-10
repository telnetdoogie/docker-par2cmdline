ARG PAR2CMDLINE_VERSION=1.2.0
ARG TARGETARCH
ARG TARGETVARIANT

FROM alpine:3.21.0
#debug
RUN echo "TARGETARCH=$TARGETARCH, TARGETVARIANT=$TARGETVARIANT"

RUN apk add --no-cache curl
# Map TARGETARCH and TARGETVARIANT to the correct binary name
RUN case "$TARGETARCH$TARGETVARIANT" in \
        "amd64") ARCH_SUFFIX="x86_64" ;; \
        "arm64") ARCH_SUFFIX="aarch64" ;; \
        "armv7") ARCH_SUFFIX="armhf" ;; \
        *) echo "Unsupported architecture: $TARGETARCH$TARGETVARIANT" && exit 1 ;; \
    esac && \
    curl -L "https://github.com/animetosho/par2cmdline-turbo/releases/download/v${PAR2CMDLINE_VERSION}/par2cmdline-turbo_${ARCH_SUFFIX}" -o /usr/local/bin/par2cmdline-turbo && \
    chmod +x /usr/local/bin/par2cmdline-turbo

COPY ./par.sh /
RUN chmod +x /par.sh
RUN mkdir -p /par2_files/
WORKDIR /par2_files
ENTRYPOINT ["/par.sh"]
