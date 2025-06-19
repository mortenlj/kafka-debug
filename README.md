# kafka-debug
A docker image used for debugging kafka and kubernetes related issues

Installs many tools (see the [Earthfile](./Earthfile) or [mise.toml](./mise.toml) for details).

Most notable:
- curl
- [grpcurl](https://github.com/fullstorydev/grpcurl)
- httpie
- jq
- [k9s](https://github.com/derailed/k9s)
- [kafkactl](https://github.com/deviceinsight/kafkactl)
- kubectl
- [kubeseal](https://github.com/bitnami-labs/sealed-secrets)
- [kubespy](https://github.com/pulumi/kubespy)
- [kubetail](https://github.com/johanhaleby/kubetail)
- micro
- mosquitto-clients
- nano
- nmap
- openssl
- postgresql15-client
- postgresql16-client
- postgresql17-client
- redis
- tcpdump
- valkey-cli
- vim
- wget
- [yq](https://github.com/mikefarah/yq)


## Usage

Launch a docker container:

`docker run -ti --rm ghcr.io/mortenlj/kafka-debug:latest bash`

Launch into a kubernetes cluster:

`kubectl run kafka-debug --image=ghcr.io/mortenlj/kafka-debug:latest`

Exec into existing pod in kubernetes cluster:

`kubectl exec -ti kafka-debug -- bash`
