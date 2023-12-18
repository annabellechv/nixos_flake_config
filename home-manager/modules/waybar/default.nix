{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or  [ ]) ++ [ "-Dexperimental=true" ];
    });

    systemd.enable = true;

    style = ./style.css;

    settings = {
      top = {
        layer = "top";
        position = "top";
        height = 30;
        margin-right = 5;
        margin-left = 5;
        spacing = 5;
        mode = "dock";

        modules-left = [
          "cpu"
          "memory"
          "temperature"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "pulseaudio"
          "network"
          "backlight"
          "bluetooth"
          "battery"
          "clock"
          "group/power"
        ];

        
        "backlight" = {
          device = "intel_backlight";
          format = "{icon} {percent}%";
          format-icons = [ "☼" "☀︎" ];
        };

        "battery" = {
          bat = "BAT0";
          states = {
            warning = 30;
            critical = 20;
          };
          format = "{icon} {capacity}%";
          format-icons = [ "" "" "" "" "" ];
          format-charging = "{icon} {capacity}%";
          format-plugged = "{icon} {capacity}%";
        };

        "bluetooth" = {
          format = " {status}";
          format-connected = " {device_alias}";
        };

        "clock" = {
          format = " {:%H:%M}";
          format-alt = "{:%A, %d %B %Y}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
        };

        "cpu" = {
          interval = 1;
          format = " {}%";
        };
        
        "group/power" = {
          orientation = "horizontal";
          drawer = {
            children-class = "power";
            transistion-left-to-right = false;
          };
          modules = [
            "custom/power"
            "custom/quit"
            "custom/lock"
            "custom/reboot"
          ];
        };

        "custom/power" = {
          format = "  ";
          tooltip = false;
          on-click = "systemctl shutdown";
        };

        "custom/quit" = {
          format = "  ";
          tooltip = false;
          on-click = "hyprctl dispatch exit";
        };

        "custom/lock" = {
          format = "  ";
          tooltip = false;
          on-click = "swaylock -S";
        };

        "custom/reboot" = {
          format = "  ";
          tooltip = false;
          on-click = "systemctl reboot";
        };

        "hyprland/workspaces" = {
          format = " {name} {windows}";
          format-window-separator = " ";
          window-rewrite-default = "";
          window-rewrite = {
            firefox  = "󰈹";
            kitty = "󰞷";
            discord = "";
            thunar = "";
          };
        };

        "memory" = {
          interval = 30;
          format = " {percentage}%";
        };

        "network" = {
          format = "  {ifname}";
          format-wifi = "  {essid} ({signalStrength}%)";
          format-ethernet = "{ipaddr}/{cidr} 󰊗";
          format-disconnected = "Disconnected"; # An empty format will hide the module.
          tooltip-format = "{ifname} via {gwaddr} 󰊗";
          tooltip-format-wifi = " { essid} ({signalStrength}%)";
          tooltip-format-ethernet = "{ifname} ";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}% ";
          format-muted = "";
          format-icons = {
            headphone = "";
            headset = "";
            default = [ "" "" ""];
          };
          scroll-step = 1;
          on-click = "pavucontrol";
        };

        "temperature" = {
          format = "{icon} {temperatureC}°C";
          format-icons = [ "" "" "" "" "" ];
          critical-threshold = 80;
        };
      };
    };
  };
}
