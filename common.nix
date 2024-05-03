{ pkgs, lib, config, ... }:
{
  nix.settings.experimental-features = "nix-command flakes";
  services.nix-daemon.enable = true;
  security.pam.enableSudoTouchIdAuth = true;
#  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 4;
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
    EDITOR = lib.mkForce "hx";
  };

  users.users.tim = {
    name = "tim";
    home = "/Users/tim";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGTyL1sUxqVqkerCHuYgil+jq8HeGQ9E9mSFmdqnRsJz tim@mercury"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICOhD4lak0C8NC9AiroulW3MgavGGJ4fwHeI6jvcMgHZ tim@mars"
    ];
  };

  environment.systemPackages = with pkgs; [
    nil
  ];

  homebrew = {
    enable = true;
#    onActivation.cleanup = "uninstall";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;

    taps = [];
    brews = [
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
      "starship"
      "terminal-notifier"
      "zellij"
      "mise"
      "pidof"
      "tree"
      "awscli"
      "websocat"
      "tmate"
      "vim"
    ];
    casks = [
      "1password"
      "1password-cli"
      "bartender"
      "bruno"
      "discord"
      "docker"
      "easy-move-plus-resize"
      "fantastical"
      "gitify"
      "google-chrome"
      "handbrake"
      "insomnia"
      "intellij-idea"
      "iterm2"
      "linearmouse"
      "plex-media-server"
      "obsidian"
      "obs"
      "raycast"
      "rectangle-pro"
      "shottr"
      "slack"
      "signal"
      "todoist"
      "visual-studio-code"
      "vlc"
      "jetbrains-toolbox"
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
