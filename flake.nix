{
  description = "tim@mars configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
        url = "github:LnL7/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = {pkgs, ... }: {

        services.nix-daemon.enable = true;
        nix.settings.experimental-features = "nix-command flakes";

        system.configurationRevision = self.rev or self.dirtyRev or null;
        system.stateVersion = 4;
        security.pam.enableSudoTouchIdAuth = true;

        nixpkgs.hostPlatform = "aarch64-darwin";

        users.users.tim = {
            name = "tim";
            home = "/Users/tim";
        };

        programs.zsh.enable = true;
        programs.fish.enable = true;
#        programs.starship.enable = true;

        environment.systemPackages = [
            pkgs.vim
            pkgs.neofetch
            pkgs.zellij
            pkgs.eza
            pkgs.bat
        ];

        homebrew = {
            enable = true;
            # onActivation.cleanup = "uninstall";

            taps = [];
            brews = [ "cowsay" "starship" ];
            casks = [];
        };

    };
  in
  {
    darwinConfigurations."mars" = nix-darwin.lib.darwinSystem {
      modules = [
         configuration
      ];
    };
  };
}
