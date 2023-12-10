{ lib, config, pkgs, ... }:
{
  imports = [
    ./hyprpaper.nix
  ];

  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
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

      general {
        border_size = 2
        gaps_in = 6
        gaps_out = 10
        col.inactive_border = rgb(150457)
        col.active_border = rgb(C85CE7)
        resize_on_border = true
      }

      decoration {
        rounding = 10
      }

      animations {
      }

      input {
        kb_layout = us
        kb_variant = intl
        touchpad {
          natural_scroll = true
          scroll_factor = 0.6
          tap-to-click = true
          tap-and-drag = true
        }
      }

      gestures {
        workspace_swipe = true
        workspace_swipe_fingers = 3
      }

      misc {
        disable_hyprland_logo = true
        force_default_wallpaper = 0
        mouse_move_enables_dpms = true
        key_press_enables_dpms = true
      }

      monitor = eDP-1,  1920x1080@60, 0x0,  1
      monitor =      ,  preferred,    auto, 1

      bindm = $mod, mouse:272, movewindow
      bindm = $mod, mouse:273, resizewindow
 
      bind = $mod, F,       exec, firefox
      bind = $mod, Return,  exec, kitty
      bind = $mod, Space,   exec, swaylock -S
      bind = $mod, D,       exec, rofi -modi drun -show drun -show-icons
      bind =     , PRINT,   exec, grim -g "$(slurp -d)" - | wl-copy

      bind = $mod SHIFT, S, exec, grim -g "$(slurp -d)" - | wl-copy
      bind = $mod SHIFT, Q, killactive
      bind = $mod SHIFT, E, exit

      bind = , XF86MonBrightnessUp,   exec, light -A 5
      bind = , XF86MonBrightnessDown, exec, light -U 5

      bind = , XF86AudioRaiseVolume,  exec, amixer -q sset Master 1%+
      bind = , XF86AudioLowerVolume,  exec, amixer -q sset Master 1%-
      bind = , XF86AudioMute,         exec, amixer -q sset Master toggle

      bind = $mod, left,  movefocus, l
      bind = $mod, right, movefocus, r
      bind = $mod, up,    movefocus, u
      bind = $mod, down,  movefocus, d

      bind = $mod SHIFT, left,  swapwindow, l
      bind = $mod SHIFT, right, swapwindow, r
      bind = $mod SHIFT, up,    swapwindow, u
      bind = $mod SHIFT, down,  swapwindow, d

    '';
  };
}
