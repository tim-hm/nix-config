{ pkgs, lib, config, ... }:
{
  home.stateVersion = "23.05";

  home.file = {
    ".gitconfig".source = dotfiles/gitconfig;
    ".zshrc".source = dotfiles/zshrc;
    ".vimrc".source = dotfiles/vimrc;
  };

  programs.home-manager.enable = true;
}
