.PHONY: build cluster test

default: build

build:
	go build -o bin/swarm    git.pirl.io/bitcoiin/go-bitcoiin/cmd/swarm
	go build -o bin/geth     git.pirl.io/bitcoiin/go-bitcoiin/cmd/geth
	go build -o bin/bootnode git.pirl.io/bitcoiin/go-bitcoiin/cmd/bootnode

cluster: build
	scripts/boot-cluster.sh

test:
	go test -v git.pirl.io/bitcoiin/go-bitcoiin/swarm/...
