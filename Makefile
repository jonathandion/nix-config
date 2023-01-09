default: help

HOST=$(shell hostname | sed s/.local//g)

help: 
	./result/sw/bin/darwin-rebuild --help

build: 
	@echo "Building config..."
	nix build .#darwinConfigurations.myMacbook.system --extra-experimental-features "nix-command flakes"

switch: 
	@echo "Switching config..."
	./result/sw/bin/darwin-rebuild switch --flake .#myMacbook

update:
	@echo "Updating..."
	nix flake update

lint-nix: 
	@echo "Linting nix files..."
	alejandra .

lint-bash:
	@echo "Linting bash files..."
	shellcheck ./bin/*

lint:
	@echo "Linting..."
	make lint-nix
	make lint-bash

clean:
	@echo "Cleaning..."
	rm -rf result
