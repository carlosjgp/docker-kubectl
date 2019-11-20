ARG ALPINE_VERSION
FROM alpine:${ALPINE_VERSION} as downloader

ARG KUBECTL_VERSION

WORKDIR /tmp

RUN apk add --no-cache curl

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl

# Latest alpine
FROM alpine:${ALPINE_VERSION}

RUN apk add --no-cache bash

COPY --from=downloader /tmp/kubectl /usr/local/bin/kubectl

ENTRYPOINT ["kubectl"]