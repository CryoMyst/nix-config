{ pkgs, home-manager, userConfig, ... }: {
  imports = [
    ./../base/boot.nix
    ./../base/user.nix
    ./../base/home-manager.nix
    ./../system/network-manager.nix
    ./qt.nix
    ./gtk.nix
    ./sound.nix
    ./swayidle.nix
    ./swaylock.nix
    ./i3status.nix
    ./xserver.nix
    ./alacritty.nix
  ];

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  home-manager.users = {
    ${userConfig.username} = {
      wayland = {
        windowManager = {
          sway = {
            enable = true;

            config = rec {
              modifier = "Mod4";
              terminal = "alacritty";
              startup = [

              ];
              defaultWorkspace = "1";
              floating = { titlebar = true; };
              focus = { mouseWarping = false; };

              keybindings = let
                # Just redefine here for now
                modifier = "Mod4";
              in pkgs.lib.mkOptionDefault {
                "${modifier}+Shift+Escape" = "exec pkill -SIGUSR1 swayidle";
                "${modifier}+d" = "exec wofi --show drun";
                "${modifier}+Shift+d" = "exec wofi --show run";
                # "${modifier}+n" = "exec pkill -SIGUSR1 '^waybar$'"; # Kills it currently

                # Screenshot
                "${modifier}+Print" = ''exec grim -g "$(slurp)" - | wl-copy'';
                # Edit the system flake
                "${modifier}+f1" =
                  "exec ${pkgs.vscode}/bin/code /etc/nixos/flake/";
              };

              bars = [{
                fonts = {
                  names = [ "DejaVu Sans Mono" "FontAwesome5Free" ];
                  size = 11.0;
                };
                mode = "dock";
                hiddenState = "hide";
                position = "bottom";
                statusCommand = "${pkgs.i3status}/bin/i3status";
                command = "${pkgs.sway}/bin/swaybar";
                workspaceButtons = true;
                workspaceNumbers = false;
                trayOutput = "primary";
                colors = {
                  "background" = "#000000";
                  "statusline" = "#ffffff";
                  "separator" = "#666666";
                  "focusedWorkspace" = {
                    border = "#4c7899";
                    background = "#285577";
                    text = "#ffffff";
                  };
                  "activeWorkspace" = {
                    border = "#333333";
                    background = "#5f676a";
                    text = "#ffffff";
                  };
                  "inactiveWorkspace" = {
                    border = "#333333";
                    background = "#222222";
                    text = "#888888";
                  };
                  "urgentWorkspace" = {
                    border = "#2f343a";
                    background = "#900000";
                    text = "#ffffff";
                  };
                  "bindingMode" = {
                    border = "#2f343a";
                    background = "#900000";
                    text = "#ffffff";
                  };
                };
              }];

              modes = {
                resize = {
                  Escape = "mode default";
                  Return = "mode default";
                  h = "resize shrink width 10 px";
                  j = "resize grow height 10 px";
                  k = "resize shrink height 10 px";
                  l = "resize grow width 10 px";
                };
              };

              output = { "*" = { bg = "#000000 solid_color"; }; };
            };
          };
        };
      };
    };
  };
}
