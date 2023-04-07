FROM alpine:latest
RUN apk add par2cmdline
COPY ./par.sh /
RUN mkdir -p /par2_files/
WORKDIR /par2_files
ENTRYPOINT ["/par.sh"]
