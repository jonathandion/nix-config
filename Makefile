default: build

HOST=$(shell hostname | sed s/.local//g)

build: 
	@echo "Building config..."
	nix build .#darwinConfigurations.${HOST}.system --extra-experimental-features "nix-command flakes" 

install: 
	@echo "Installing config..."
	./result/sw/bin/darwin-rebuild switch --flake .

clean:
	@echo "Cleaning..."
	rm -rf result