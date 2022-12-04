FROM alpine:3.17
LABEL maintainer="Thomas GUIRRIEC <thomas@guirriec.fr>"
RUN apk add --update --no-cache git \
      texlive-full \
    && rm -rf \
         /tmp/* \
         /root/.cache/*
ENTRYPOINT ["/bin/sh"]
