FROM alpine:20221110
RUN apk add par2cmdline
COPY ./par.sh /
RUN chmod +x /par.sh
RUN mkdir -p /par2_files/
WORKDIR /par2_files
ENTRYPOINT ["/par.sh"]
