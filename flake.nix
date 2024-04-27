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
        system.keyboard.remapCapsLockToEscape = true;

        system.defaults.finder = {
            AppleShowAllExtensions = true;
            ShowPathbar = true;
            _FXShowPosixPathInTitle = false;
        };

        nixpkgs.config.allowUnfree = true;
        nixpkgs.hostPlatform = "aarch64-darwin";

        users.users.tim = {
            name = "tim";
            home = "/Users/tim";
        };



        programs.fish = {
          enable = true;
          interactiveShellInit = "starship init fish | source";
          loginShellInit =
            let
            # This naive quoting is good enough in this case. There shouldn't be any
            # double quotes in the input string, and it needs to be double quoted in case
            # it contains a space (which is unlikely!)
            dquote = str: "\"" + str + "\"";

            makeBinPathList = map (path: path + "/bin");
            in ''
              fish_add_path --move --prepend --path ${lib.concatMapStringsSep " " dquote (makeBinPathList config.environment.profiles)}
              set fish_user_paths $fish_user_paths
            '';
            vendor.completions.enable = true;
        };

        programs.vim = {
            enable = true;
            enableSensible = true;
        };

        environment.systemPackages = with pkgs; [
            bat
            curl
            eza
            gh
            git
            helix
            iterm2
            neofetch
            raycast
            rectangle
            zellij
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
