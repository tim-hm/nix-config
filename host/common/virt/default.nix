{ desktop, lib, ... }: {
  imports = [
    ./docker.nix
    ./lxd
    ./multipass.nix
  ] # Include quickemu if a desktop is defined
  ++ lib.optional (builtins.isString desktop) ./quickemu.nix;
}
