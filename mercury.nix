{ config, pkgs, ... }:
{
  imports = [
    ./common.nix
  ];

  networking = {
    computerName = "mercury";
    hostName = "mercury";
  };

  environment.systemPackages = with pkgs; [];

  homebrew = {
    casks = [
        "asana"
        "loom"
        "notion"
        "zoom"
    ];
  };
}
