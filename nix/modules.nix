{ lib, pkgs, config, home-manager, ... }:
with lib;                      
let
  cfg = config.cryo;
in {
  imports = [
    ./features/features.nix
    ./personal/personal.nix
    ./setups/setups.nix
  ];

  options.cryo = {
    username = mkOption {
      type = types.str;
      description = ''
        The username to setup.
      '';
    };
    hostname = mkOption {
      type = types.str;
      description = ''
        The hostname to setup.
      '';
    };
  };
}