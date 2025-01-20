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
            nano \
            libcurl \
            lz4-libs \
            zstd-dev \
            libsasl \
            coreutils \
            mosquitto-clients \
            postgresql15-client \
            hey \
            redis \
            valkey

    COPY files/bash/bash-*.sh /etc/bash/

    CMD ["tail", "-f", "/dev/null"]

kubectl:
    FROM +tools
    ARG KUBECTL_VERSION=v1.29.3

    RUN curl -Lo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl && \
        curl -Lo /tmp/kubectl.sha256 https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/${TARGETARCH}/kubectl.sha256 && \
        echo "$(cat /tmp/kubectl.sha256)  /usr/local/bin/kubectl" | sha256sum -c -  && \
        rm -f /tmp/kubectl.sha256 && \
        chmod a+x /usr/local/bin/kubectl
    SAVE ARTIFACT /usr/local/bin/kubectl kubectl
    SAVE IMAGE --cache-hint

kubetail:
    FROM +tools
    ARG KUBETAIL_VERSION=1.6.20

    RUN mkdir -p /tmp/kubetail \
        && curl -SL https://github.com/johanhaleby/kubetail/archive/${KUBETAIL_VERSION}.tar.gz \
        | tar -xzC /tmp/kubetail \
        && mv /tmp/kubetail/kubetail-${KUBETAIL_VERSION}/kubetail /usr/local/bin/ \
        && chmod a+x /usr/local/bin/kubetail \
        && rm -rf /tmp/kubetail
    SAVE ARTIFACT /usr/local/bin/kubetail kubetail
    SAVE IMAGE --cache-hint

kubeseal:
    FROM +tools

    RUN mkdir -p /tmp/kubeseal \
        && export KUBESEAL_VERSION=$(curl -s https://api.github.com/repos/bitnami-labs/sealed-secrets/tags | jq -r '.[0].name' | cut -c 2-) \
        && curl -SL https://github.com/bitnami-labs/sealed-secrets/releases/download/v${KUBESEAL_VERSION}/kubeseal-${KUBESEAL_VERSION}-linux-${TARGETARCH}.tar.gz \
        | tar -xzC /tmp/kubeseal \
        && mv /tmp/kubeseal/kubeseal /usr/local/bin/ \
        && chmod a+x /usr/local/bin/kubeseal \
        && rm -rf /tmp/kubeseal
    SAVE ARTIFACT /usr/local/bin/kubeseal kubeseal
    SAVE IMAGE --cache-hint

kubespy:
    FROM +tools
    ARG KUBESPY_VERSION=v0.6.3

    RUN mkdir -p /tmp/kubespy \
        && curl -SL https://github.com/pulumi/kubespy/releases/download/${KUBESPY_VERSION}/kubespy-${KUBESPY_VERSION}-linux-${TARGETARCH}.tar.gz \
        | tar -xzC /tmp/kubespy \
        && mv /tmp/kubespy/kubespy /usr/local/bin/ \
        && chmod a+x /usr/local/bin/kubespy \
        && rm -rf /tmp/kubespy
    SAVE ARTIFACT /usr/local/bin/kubespy kubespy
    SAVE IMAGE --cache-hint

k9s:
    FROM +tools
    ARG K9S_VERSION=v0.32.4

    RUN mkdir -p /tmp/k9s \
        && curl -SL https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_${TARGETARCH}.tar.gz \
        | tar -xzC /tmp/k9s \
        && mv /tmp/k9s/k9s /usr/local/bin/ \
        && chmod a+x /usr/local/bin/k9s \
        && rm -rf /tmp/k9s
    SAVE ARTIFACT /usr/local/bin/k9s k9s
    SAVE IMAGE --cache-hint

yq:
    FROM +tools
    ARG YQ_VERSION=v4.43.1

    RUN curl -SLo /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_${TARGETARCH} \
        && chmod a+x /usr/local/bin/yq
    SAVE ARTIFACT /usr/local/bin/yq yq
    SAVE IMAGE --cache-hint

grpcurl:
    FROM +tools
    ARG GRPCURL_VERSION=1.9.1

    IF [ "${TARGETARCH}" == "amd64" ]
        ARG ARCH="x86_64"
    ELSE
        ARG ARCH="${TARGETARCH}"
    END

    RUN mkdir -p /tmp/grpcurl \
        && curl -SL https://github.com/fullstorydev/grpcurl/releases/download/v${GRPCURL_VERSION}/grpcurl_${GRPCURL_VERSION}_linux_${ARCH}.tar.gz \
        | tar -xzC /tmp/grpcurl \
        && mv /tmp/grpcurl/grpcurl /usr/local/bin/ \
        && chmod a+x /usr/local/bin/grpcurl \
        && rm -rf /tmp/grpcurl
    SAVE ARTIFACT /usr/local/bin/grpcurl grpcurl
    SAVE IMAGE --cache-hint

kcat:
    FROM +tools
    ARG KCAT_VERSION=1.7.0
    ARG BUILD_DEPS=bash make gcc g++ cmake curl pkgconfig python3 perl bsd-compat-headers zlib-dev zstd-dev zstd-libs lz4-dev openssl-dev curl-dev

    RUN mkdir -p /tmp/kcat \
        && curl -SL https://github.com/edenhill/kcat/archive/refs/tags/${KCAT_VERSION}.tar.gz \
        | tar -xzC /tmp/kcat \
        && apk add --no-cache --virtual .dev_pkgs $BUILD_DEPS \
        && cd /tmp/kcat/kcat-${KCAT_VERSION} \
        && ./bootstrap.sh --no-install-deps --no-enable-static \
        && mv kcat /usr/local/bin/kcat
    SAVE ARTIFACT /usr/local/bin/kcat kcat
    SAVE IMAGE --cache-hint

docker:
    FROM +tools
    COPY +kubectl/kubectl /usr/local/bin/kubectl
    COPY +kubetail/kubetail /usr/local/bin/kubetail
    COPY +kubeseal/kubeseal /usr/local/bin/kubeseal
    COPY +k9s/k9s /usr/local/bin/k9s
    COPY +yq/yq /usr/local/bin/yq
    COPY +grpcurl/grpcurl /usr/local/bin/grpcurl
    COPY +kubespy/kubespy /usr/local/bin/kubespy
    IF [ "${TARGETARCH}" == "amd64" ]
        COPY +kcat/kcat /usr/local/bin/kcat
    END

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
