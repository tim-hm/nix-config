{ self, pkgs, lib, ... }:
{
  system.stateVersion = 4;
  system.configurationRevision = self.rev or self.dirtyRev or null;

  nix.settings.experimental-features = "nix-command flakes";
  services.nix-daemon.enable = true;
  security.pam.enableSudoTouchIdAuth = true;

  system.keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
  };
  system.defaults = {
    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      FXPreferredViewStyle = "Nlsv";
      FXDefaultSearchScope = "SCcf";
    };
    dock = {
      autohide = true;
      mru-spaces = false;
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  environment.variables = {
    EDITOR = lib.mkForce "vim";
  };

  users.users.tim = {
    name = "tim";
    home = "/Users/tim";
  };

  environment.systemPackages = with pkgs; [
    nil
  ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;

    taps = [];
    brews = [
      "awscli"
      "bat"
      "coreutils"
      "curl"
      "eza"
      "fd"
      "fish"
      "fisher"
      "fzf"
      "gh"
      "git"
      "helix"
      "kubernetes-cli"
      "libusb"
      "mas"
      "mise"
      "pidof"
      "starship"
      "terminal-notifier"
      "tmate"
      "tree"
      "vim"
      "websocat"
      "zellij"
    ];
    casks = [
      "1password-cli"
      "1password"
      "arc"
      "bartender"
      "bruno"
      "chromedriver"
      "cmake"
      "discord"
      "docker"
      "easy-move-plus-resize"
      "element"
      "gitify"
      "google-chrome"
      "handbrake"
      "insomnia"
      "intellij-idea"
      "iterm2"
      "jetbrains-toolbox"
      "linearmouse"
      "mold"
      "obs"
      "obsidian"
      "plex-media-server"
      "raycast"
      "rectangle-pro"
      "shottr"
      "signal"
      "todoist"
      "visual-studio-code"
      "vlc"
      "watch"
      "socat"
      "jq"
    ];
    masApps = {
      "Amphetamine" = 937984704;
      "Kindle" = 302584613;
      "Microsoft Remote Desktop" = 1295203466;
      "Parallels Desktop" = 1085114709;
      "ScreenBrush" = 1233965871;
      "Tailscale" = 1475387142;
      "WhatsApp" = 310633997;
      "Xcode" = 497799835;
    };
  };

  fonts.fontDir.enable = true;
  fonts.fonts = [
    pkgs.fira-code-nerdfont
  ];
}
