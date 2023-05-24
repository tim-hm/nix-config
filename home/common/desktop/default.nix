{ pkgs, desktop, ... }: {
  imports = [
    (./. + "/${desktop}")

    ../dev

    ./alacritty.nix
    ./gtk.nix
    ./qt.nix
    ./xdg.nix
    ./zathura.nix
  ];

  programs = {
    firefox.enable = true;
    mpv.enable = true;
    feh.enable = true;
  };

  home.packages = with pkgs; [
    catppuccin-gtk
    desktop-file-utils
    google-chrome
    libnotify
    obsidian
    pamixer
    pavucontrol
    signal-desktop
    xdg-utils
    xorg.xlsclients
  ];

  fonts.fontconfig.enable = true;
}
