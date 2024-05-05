{ self, pkgs, config, ... }:
{
  imports = [
    ./common.nix
  ];

  networking = {
    computerName = "mars";
    hostName = "mars";
  };

  environment.systemPackages = with pkgs; [];

  homebrew = {
    brews = [];
    casks = [
      "transmission"
    ];
  };
}
