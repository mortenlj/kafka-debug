VERSION 0.8

ARG --global TARGETARCH

tools:
    FROM alpine:3

    RUN apk add --no-cache \
            bash \
            bind-tools \
            busybox-extras \
            ca-certificates \
            coreutils \
            curl \
            hey \
            httpie \
            iperf \
            iputils \
            jq \
            k9s \
            kubectl \
            libcurl \
            libsasl \
            lz4-libs \
            micro \
            mosquitto-clients \
            mtr \
            nano \
            netcat-openbsd \
            nmap \
            openssl \
            postgresql15-client \
            postgresql16-client \
            postgresql17-client \
            redis \
            socat \
            strace \
            tcpdump \
            tcptraceroute \
            valkey-cli \
            vim \
            wget \
            yq \
            zstd-dev

    COPY files/bash/bash-*.sh /etc/bash/

    CMD ["tail", "-f", "/dev/null"]

mise:
    FROM +tools

    RUN apk add --no-cache \
            mise

    COPY mise.toml .
    RUN mise trust /mise.toml \
        && mise install \
        && cp /root/.local/share/mise/installs/*/latest/* /usr/local/bin/
    SAVE ARTIFACT /usr/local/bin localbin
    SAVE IMAGE --cache-hint

docker:
    FROM +tools
    COPY +mise/localbin /usr/local/bin

    # builtins must be declared
    ARG EARTHLY_GIT_PROJECT_NAME
    ARG EARTHLY_GIT_SHORT_HASH

    # Override from command-line on CI
    ARG main_image=ghcr.io/$EARTHLY_GIT_PROJECT_NAME
    ARG VERSION=$EARTHLY_GIT_SHORT_HASH

    WORKDIR /tmp
    SAVE IMAGE --push ${main_image}:${VERSION} ${main_image}:latest

deploy:
    BUILD --platform=linux/amd64 --platform=linux/arm64 +docker
