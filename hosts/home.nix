{ pkgs, lib, config, ... }:
{
  home = {
    stateVersion = "24.05";
    username = "tim";
    homeDirectory = "/Users/tim";

    file = {
      ".gitconfig".source = ../dotfiles/gitconfig;
      ".zshrc".source = ../dotfiles/zshrc;
      ".vimrc".source = ../dotfiles/vimrc;
      ".ssh/authorized_keys".source = ../dotfiles/ssh_authorized_keys;
    };
  };

  programs.home-manager.enable = true;
}
