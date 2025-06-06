# kafka-debug
A docker image used for debugging kafka and kubernetes related issues

Installs many tools (see the [Earthfile](./Earthfile) for details).

Most notable:
- [kcat](https://github.com/edenhill/kcat)
- kubectl
- [kubetail](https://github.com/johanhaleby/kubetail)
- [kubespy](https://github.com/pulumi/kubespy)
- [kubeseal](https://github.com/bitnami-labs/sealed-secrets)
- [k9s](https://github.com/derailed/k9s)
- [yq](https://github.com/mikefarah/yq)
- [grpcurl](https://github.com/fullstorydev/grpcurl)
- curl
- wget
- httpie
- jq
- tcpdump
- nmap
- nano
- vim
- openssl
- mosquitto-clients
- postgresql17-client
- redis
- valkey


## Usage

Launch a docker container:

`docker run -ti --rm ghcr.io/mortenlj/kafka-debug:latest bash`

Launch into a kubernetes cluster:

`kubectl run kafka-debug --image=ghcr.io/mortenlj/kafka-debug:latest`

Exec into existing pod in kubernetes cluster:

`kubectl exec -ti kafka-debug -- bash`
