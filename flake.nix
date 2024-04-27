{
  description = "tim@mars configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    configuration = {pkgs, lib, config, ... }: {

        services.nix-daemon.enable = true;
        nix.settings.experimental-features = "nix-command flakes";

        system.configurationRevision = self.rev or self.dirtyRev or null;
        system.stateVersion = 4;
        security.pam.enableSudoTouchIdAuth = true;
        system.keyboard = {
            enableKeyMapping = true;
            remapCapsLockToEscape = true;
        };

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
            onActivation.cleanup = "uninstall";
            onActivation.autoUpdate = true;
            onActivation.upgrade = true;

            taps = [];
            brews = [
                "kubernetes-cli"
                "starship"
                "mas"
            ];
            casks = [
                "1password"
                "1password-cli"
                "bruno"
                "easy-move-plus-resize"
                "gitify"
                "handbrake"
                "insomnia"
                "linearmouse"
                "plex-media-server"
                "shottr"
                "signal"
            ];
            masApps = {
                "WhatsApp" = 310633997;
                "Tailscale" = 1475387142;
                "Microsoft Remote Desktop" = 1295203466;
                "Amphetamine" = 937984704;
                "ScreenBrush" = 1233965871;
                "Xcode" = 497799835;
                "Kindle" = 302584613;
            };
        };

        fonts.fonts = [
            pkgs.fira-code-nerdfont
        ];
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
