{ self, pkgs, config, ... }:
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
        "slack"
        "zoom"
    ];
  };
}
