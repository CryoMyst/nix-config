{ lib, pkgs, config, home-manager, ... }:
with lib;                      
let
  cryo = config.cryo;
  cfg = config.cryo.features.tmux;
in {
  options.cryo.features.tmux = {
    enable = mkEnableOption "Enable tmux";
  };

  config = mkIf cfg.enable {
    home-manager.users = {
      ${cryo.username} = { 
        programs = { 
          tmux = {
            enable = true;
            clock24 = true;
            disableConfirmationPrompt = false;
            extraConfig = ''
              bind h select-pane -L
              bind j select-pane -D
              bind k select-pane -U
              bind l select-pane -R

              set -g status-position top
              set -g mouse on
            '';
            keyMode = "vi";
            mouse = false;
            newSession = false;
            plugins = with pkgs.tmuxPlugins; [
              vim-tmux-navigator
              sensible
              yank
              {
                plugin = dracula;
                extraConfig = ''
                  set -g @dracula-show-battery false
                  set -g @dracula-show-powerline true
                  set -g @dracula-refresh-rate 10
                  set -g @dracula-show-flags true
                  set -g @dracula-show-left-icon session
                '';
              }
            ];
            # Overriden by shortcut
            # prefix = "C-b";
            reverseSplit = false;
            secureSocket = false;
            sensibleOnTop = true;
            shell = null;
            shortcut = "s";
            terminal = "screen";
          };
        };
      };
    };
  };
}