{ lib
, ...
}: {
  imports = [
    ./boot.nix
    ./hardware.nix

    ../common/global
    ../common/users/jon

    ../common/optional/virt

    ../common/optional/desktop.nix
    ../common/optional/greetd.nix
    ../common/optional/nautilus.nix
    ../common/optional/yubikey.nix
  ];

  networking = {
    hostName = "loki";
    # head -c4 /dev/urandom | od -A none -t x4
    hostId = "4c53e052";
    useDHCP = lib.mkDefault true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22000 # syncthing
      ];
      allowedUDPPorts = [
        22000 # syncthing
        21027 # syncthing
      ];
    };
  };

  environment.systemPackages = [ ];

  system.stateVersion = "22.11";
}
