default: help

HOST=$(shell hostname | sed s/.local//g)

help: 
	@echo "Rollbacking config..."
	./result/sw/bin/darwin-rebuild --help

build: 
	@echo "Building config..."
	nix build .#darwinConfigurations.myMacbook.system --extra-experimental-features "nix-command flakes"

install: 
	@echo "Installing config..."
	./result/sw/bin/darwin-rebuild switch --flake .#myMacbook

pull-nvim:
	@echo "Pulling nvim config..."
	nix flake lock --update-input nvim

clean:
	@echo "Cleaning..."
	rm -rf result
