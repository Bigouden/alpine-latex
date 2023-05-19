FROM alpine:3.18
LABEL maintainer="Thomas GUIRRIEC <thomas@guirriec.fr>"
ENV UID="1000"
ENV USERNAME="latex"
COPY apk_packages /
RUN xargs -a /apk_packages apk add --no-cache --update \
    && useradd -l -u "${UID}" -U -s /bin/sh -m "${USERNAME}" \
    && rm -rf \
         /tmp/* \
         /root/.cache/*
USER ${USERNAME}
WORKDIR /tmp
ENTRYPOINT ["/bin/sh"]
