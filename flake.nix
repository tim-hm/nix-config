{
  description = "Tim's nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... }:
    let
      darwinSystem = { system, hostname }: nix-darwin.lib.darwinSystem  {
        inherit system;
        pkgs = import nixpkgs { inherit system; };
        specialArgs = { inherit self; };
        modules = [
          ./hosts/${hostname}.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.tim = import ./hosts/home.nix;
          }
        ];
      };
    in {
      darwinConfigurations.mercury = darwinSystem { hostname = "mercury"; system = "aarch64-darwin"; };
      darwinConfigurations.mars = darwinSystem  { hostname = "mars"; system = "aarch64-darwin"; };
    };
#    nixosConfigurations."my-x86-machine" = nixpkgs.lib.nixosSystem {
#        system = "x86_64-linux";
#        modules = [ ./configuration.nix ];
#    };
}
