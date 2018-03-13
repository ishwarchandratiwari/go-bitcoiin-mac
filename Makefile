# This Makefile is meant to be used by people that do not usually work
# with Go source code. If you know what GOPATH is then you probably
# don't need to bother with make.

.PHONY: bitcoiin android ios bitcoiin-cross swarm evm all test clean
.PHONY: bitcoiin-linux bitcoiin-linux-386 bitcoiin-linux-amd64 bitcoiin-linux-mips64 bitcoiin-linux-mips64le
.PHONY: bitcoiin-linux-arm bitcoiin-linux-arm-5 bitcoiin-linux-arm-6 bitcoiin-linux-arm-7 bitcoiin-linux-arm64
.PHONY: bitcoiin-darwin bitcoiin-darwin-386 bitcoiin-darwin-amd64
.PHONY: bitcoiin-windows bitcoiin-windows-386 bitcoiin-windows-amd64

GOBIN = $(shell pwd)/build/bin
GO ?= latest

bitcoiin:
	build/env.sh go run build/ci.go install ./cmd/bitcoiin
	@echo "Done building."
	@echo "Run \"$(GOBIN)/bitcoiin\" to launch bitcoiin."

swarm:
	build/env.sh go run build/ci.go install ./cmd/swarm
	@echo "Done building."
	@echo "Run \"$(GOBIN)/swarm\" to launch swarm."

all:
	build/env.sh go run build/ci.go install

android:
	build/env.sh go run build/ci.go aar --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/bitcoiin.aar\" to use the library."

ios:
	build/env.sh go run build/ci.go xcode --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/Bitcoiin.framework\" to use the library."

test: all
	build/env.sh go run build/ci.go test

clean:
	rm -fr build/_workspace/pkg/ $(GOBIN)/*

# The devtools target installs tools required for 'go generate'.
# You need to put $GOBIN (or $GOPATH/bin) in your PATH to use 'go generate'.

devtools:
	env GOBIN= go get -u golang.org/x/tools/cmd/stringer
	env GOBIN= go get -u github.com/kevinburke/go-bindata/go-bindata
	env GOBIN= go get -u github.com/fjl/gencodec
	env GOBIN= go get -u github.com/golang/protobuf/protoc-gen-go
	env GOBIN= go install ./cmd/abigen
	@type "npm" 2> /dev/null || echo 'Please install node.js and npm'
	@type "solc" 2> /dev/null || echo 'Please install solc'
	@type "protoc" 2> /dev/null || echo 'Please install protoc'

# Cross Compilation Targets (xgo)

bitcoiin-cross: bitcoiin-linux bitcoiin-darwin bitcoiin-windows bitcoiin-android bitcoiin-ios
	@echo "Full cross compilation done:"
	@ls -ld $(GOBIN)/bitcoiin-*

bitcoiin-linux: bitcoiin-linux-386 bitcoiin-linux-amd64 bitcoiin-linux-arm bitcoiin-linux-mips64 bitcoiin-linux-mips64le
	@echo "Linux cross compilation done:"
	@ls -ld $(GOBIN)/bitcoiin-linux-*

bitcoiin-linux-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/386 -v ./cmd/bitcoiin
	@echo "Linux 386 cross compilation done:"
	@ls -ld $(GOBIN)/bitcoiin-linux-* | grep 386

bitcoiin-linux-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/amd64 -v ./cmd/bitcoiin
	@echo "Linux amd64 cross compilation done:"
	@ls -ld $(GOBIN)/bitcoiin-linux-* | grep amd64

bitcoiin-linux-arm: bitcoiin-linux-arm-5 bitcoiin-linux-arm-6 bitcoiin-linux-arm-7 bitcoiin-linux-arm64
	@echo "Linux ARM cross compilation done:"
	@ls -ld $(GOBIN)/bitcoiin-linux-* | grep arm

bitcoiin-linux-arm-5:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-5 -v ./cmd/bitcoiin
	@echo "Linux ARMv5 cross compilation done:"
	@ls -ld $(GOBIN)/bitcoiin-linux-* | grep arm-5

bitcoiin-linux-arm-6:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-6 -v ./cmd/bitcoiin
	@echo "Linux ARMv6 cross compilation done:"
	@ls -ld $(GOBIN)/bitcoiin-linux-* | grep arm-6

bitcoiin-linux-arm-7:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-7 -v ./cmd/bitcoiin
	@echo "Linux ARMv7 cross compilation done:"
	@ls -ld $(GOBIN)/bitcoiin-linux-* | grep arm-7

bitcoiin-linux-arm64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm64 -v ./cmd/bitcoiin
	@echo "Linux ARM64 cross compilation done:"
	@ls -ld $(GOBIN)/bitcoiin-linux-* | grep arm64

bitcoiin-linux-mips:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips --ldflags '-extldflags "-static"' -v ./cmd/bitcoiin
	@echo "Linux MIPS cross compilation done:"
	@ls -ld $(GOBIN)/bitcoiin-linux-* | grep mips

bitcoiin-linux-mipsle:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mipsle --ldflags '-extldflags "-static"' -v ./cmd/bitcoiin
	@echo "Linux MIPSle cross compilation done:"
	@ls -ld $(GOBIN)/bitcoiin-linux-* | grep mipsle

bitcoiin-linux-mips64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64 --ldflags '-extldflags "-static"' -v ./cmd/bitcoiin
	@echo "Linux MIPS64 cross compilation done:"
	@ls -ld $(GOBIN)/bitcoiin-linux-* | grep mips64

bitcoiin-linux-mips64le:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64le --ldflags '-extldflags "-static"' -v ./cmd/bitcoiin
	@echo "Linux MIPS64le cross compilation done:"
	@ls -ld $(GOBIN)/bitcoiin-linux-* | grep mips64le

bitcoiin-darwin: bitcoiin-darwin-386 bitcoiin-darwin-amd64
	@echo "Darwin cross compilation done:"
	@ls -ld $(GOBIN)/bitcoiin-darwin-*

bitcoiin-darwin-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/386 -v ./cmd/bitcoiin
	@echo "Darwin 386 cross compilation done:"
	@ls -ld $(GOBIN)/bitcoiin-darwin-* | grep 386

bitcoiin-darwin-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/amd64 -v ./cmd/bitcoiin
	@echo "Darwin amd64 cross compilation done:"
	@ls -ld $(GOBIN)/bitcoiin-darwin-* | grep amd64

bitcoiin-windows: bitcoiin-windows-386 bitcoiin-windows-amd64
	@echo "Windows cross compilation done:"
	@ls -ld $(GOBIN)/bitcoiin-windows-*

bitcoiin-windows-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/386 -v ./cmd/bitcoiin
	@echo "Windows 386 cross compilation done:"
	@ls -ld $(GOBIN)/bitcoiin-windows-* | grep 386

bitcoiin-windows-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/amd64 -v ./cmd/bitcoiin
	@echo "Windows amd64 cross compilation done:"
	@ls -ld $(GOBIN)/bitcoiin-windows-* | grep amd64
