# kafka-debug
A docker image used for debugging kafka and kubernetes related issues

Installs many tools (see the [Earthfile](./Earthfile) for details).

Most notable:
- kcat
- kubectl
- kubetail
- kubespy
- k9s
- yq
- curl
- wget
- httpie
- jq
- tcpdump
- nmap
- nano
- vim
- openssl

## Usage

Launch a docker container:

`docker run -ti --rm ghcr.io/mortenlj/kafka-debug:latest bash`

Launch into a kubernetes cluster:

`kubectl run kafka-debug --image=ghcr.io/mortenlj/kafka-debug:latest`

Exec into existing pod in kubernetes cluster:

`kubectl exec -ti kafka-debug -- bash`
