FROM confluentinc/cp-kafkacat:5.5.0

ENV YQ_VERSION=3.3.0
ENV KUBECTL_VERSION=v1.16.7
ENV KUBETAIL_VERSION=1.6.10
ENV KUBESPY_VERSION=v0.5.1
ENV K9S_VERSION=v0.19.2

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        vim \
        nmap \
        iputils-ping \
        iputils-arping \
        iputils-tracepath \
        tcptraceroute \
        strace \
        socat \
        netcat-openbsd \
        mtr \
        iperf \
        tcpdump \
        openssl \
        ca-certificates \
        wget \
        httpie \
        dnsutils \
        jq \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /tmp/kubetail \
    && curl -SL https://github.com/johanhaleby/kubetail/archive/${KUBETAIL_VERSION}.tar.gz \
    | tar -xzC /tmp/kubetail \
    && mv /tmp/kubetail/kubetail-${KUBETAIL_VERSION}/kubetail /usr/local/bin/ \
    && chmod a+x /usr/local/bin/kubetail \
    && rm -rf /tmp/kubetail

RUN mkdir -p /tmp/kubespy \
    && curl -SL https://github.com/pulumi/kubespy/releases/download/${KUBESPY_VERSION}/kubespy-linux-amd64.tar.gz \
    | tar -xzC /tmp/kubespy \
    && mv /tmp/kubespy/releases/kubespy-linux-amd64/kubespy /usr/local/bin/ \
    && chmod a+x /usr/local/bin/kubespy \
    && rm -rf /tmp/kubespy

RUN mkdir -p /tmp/k9s \
    && curl -SL https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_x86_64.tar.gz \
    | tar -xzC /tmp/k9s \
    && mv /tmp/k9s/k9s /usr/local/bin/ \
    && chmod a+x /usr/local/bin/k9s \
    && rm -rf /tmp/k9s

RUN curl -SLo /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64 \
    && chmod a+x /usr/local/bin/yq

RUN curl -SLo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod a+x /usr/local/bin/kubectl

# TODO: Add some setup/scripts to get kafkacat working in the nav clusters

ENTRYPOINT ["tail", "-f", "/dev/null"]
