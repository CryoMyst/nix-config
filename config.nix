{
  username = "cryomyst";
  user-description = "Cryomyst";

  computers = {
    main-desktop = {
      hostname = "cryo-desktop";
      nix-system-type = "x86_64-linux";
    };
    laptop-asahi = {
      hostname = "cryo-asahi";
      nix-system-type = "aarch64-linux";
    };
  };
}