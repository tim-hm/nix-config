{ inputs
, ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-z
    ../common/hardware/bluetooth.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  hardware = {
    enableAllFirmware = true;
    amdgpu.loadInInitrd = true;
  };

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/5b841b9d-9cc0-4875-97be-7572fac63985";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/5b841b9d-9cc0-4875-97be-7572fac63985";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

  fileSystems."/var" =
    {
      device = "/dev/disk/by-uuid/5b841b9d-9cc0-4875-97be-7572fac63985";
      fsType = "btrfs";
      options = [ "subvol=@var" ];
    };

  fileSystems."/.snapshots" =
    {
      device = "/dev/disk/by-uuid/5b841b9d-9cc0-4875-97be-7572fac63985";
      fsType = "btrfs";
      options = [ "subvol=@snapshots" ];
    };

  fileSystems."/.swap" =
    {
      device = "/dev/disk/by-uuid/5b841b9d-9cc0-4875-97be-7572fac63985";
      fsType = "btrfs";
      options = [ "subvol=@swap" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/5942-09FF";
      fsType = "vfat";
    };


  swapDevices = [{
    device = "/.swap/swapfile";
    size = 2048;
  }];

}
