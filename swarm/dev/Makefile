.PHONY: build cluster test

default: build

build:
	go build -o bin/swarm    github.com/bitcoiinBT2/go-bitcoiin/cmd/swarm
	go build -o bin/bitcoiinGo     github.com/bitcoiinBT2/go-bitcoiin/cmd/bitcoiinGo
	go build -o bin/bootnode github.com/bitcoiinBT2/go-bitcoiin/cmd/bootnode

cluster: build
	scripts/boot-cluster.sh

test:
	go test -v github.com/bitcoiinBT2/go-bitcoiin/swarm/...
