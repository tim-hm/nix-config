{ desktop, lib, pkgs, ... }: {
  imports = [
    ./cloud.nix
    ./containers.nix
    ./go.nix
    ./nix.nix
    ./python.nix
  ] ++ lib.optional (builtins.isString desktop) ./desktop.nix;
}
