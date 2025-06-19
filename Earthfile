VERSION 0.8

ARG --global TARGETARCH

tools:
    FROM alpine:3

    RUN apk add --no-cache \
            bash \
            curl \
            vim \
            nmap \
            iputils \
            tcptraceroute \
            strace \
            bind-tools \
            socat \
            netcat-openbsd \
            mtr \
            iperf \
            tcpdump \
            busybox-extras \
            openssl \
            ca-certificates \
            wget \
            httpie \
            jq \
            yq \
            nano \
            libcurl \
            lz4-libs \
            zstd-dev \
            libsasl \
            coreutils \
            mosquitto-clients \
            postgresql17-client \
            postgresql16-client \
            postgresql15-client \
            hey \
            redis \
            valkey-cli \
            kubectl \
            k9s

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
