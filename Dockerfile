# kics-scan disable=ae9c56a6-3ed1-4ac0-9b54-31267f51151d,d3499f6d-1651-41bb-a9a7-de925fea487b,

ARG ALPINE_VERSION="3.21"

FROM alpine:${ALPINE_VERSION} AS builder
COPY --link apk_packages /tmp/

FROM alpine:${ALPINE_VERSION}
LABEL maintainer="Thomas GUIRRIEC <thomas@guirriec.fr>"
ENV UID="1000"
ENV USERNAME="latex"
# hadolint ignore=DL3013,DL3018,DL3042,SC2006
RUN --mount=type=bind,from=builder,source=/tmp,target=/tmp \
    --mount=type=cache,id=apk_cache,target=/var/cache/apk \
    xargs -a /tmp/apk_packages apk --update add \
    && useradd -l -u "${UID}" -U -s /bin/sh -m "${USERNAME}"
USER ${USERNAME}
WORKDIR /tmp
HEALTHCHECK CMD latex -v || exit 1
ENTRYPOINT ["/bin/sh"]
