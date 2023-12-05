{ lib, config, pkgs, ... }:
{
  imports = [
    ./hyprpaper.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      $mod = SUPER

      # workspaces
      # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
      ${builtins.concatStringsSep "\n" (builtins.genList (
        x: let
          ws = let
            c = (x + 1) / 10;
          in
            builtins.toString (x + 1 - (c * 10));
        in ''
          bind = $mod, ${ws}, workspace, ${toString (x + 1)}
          bind = $mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
        ''
      )
      10)}

      input {
        touchpad {
          natural_scroll = true
          disable_while_typing = false
          tap-to-click = true
        }
      }

      gestures {
        workspace_swipe = true
      }

      monitor = eDP-1,1920x1080@60,0x0,1
      monitor = ,preferred,auto,1

      bind = $mod, F, exec, firefox
      bind = $mod, Return, exec, kitty
      bind = $mod, Space, exec, swaylock
      bind = $mod, D, exec, rofi -modi drun -show drun --show-icons

      bindm = $mod, mouse:272, movewindow
      bindm = $mod, mouse:273, resizewindow
 
      bind = $mod SHIFT, Q, killactive

      bind=,XF86MonBrightnessUp,exec,light -A 5
      bind=,XF86MonBrightnessDown,exec,light -U 5

      bind=,XF86AudioRaiseVolume,exec,amixer -q sset Master 1%+
      bind=,XF86AudioLowerVolume,exec,amixer -q sset Master 1%-
      bind=,XF86AudioMute,exec,amixer -q sset Master toggle

      bind=$mod,left,movefocus,l
      bind=$mod,right,movefocus,r
      bind=$mod,up,movefocus,u
      bind=$mod,down,movefocus,d

      bind=$mod SHIFT,left,swapwindow,l
      bind=$mod SHIFT,right,swapwindow,r
      bind=$mod SHIFT,up,swapwindow,u
      bind=$mod SHIFT,down,swapwindow,d

    '';
  };
}
