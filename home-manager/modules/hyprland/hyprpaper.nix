{ lib, config, pkgs, ... }:
let
  wallpaper = "~/.setup/home-manager/wallpaper-neon.jpg";
in {
  home.packages = with pkgs; [ hyprpaper ];

  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload  = ${wallpaper}
    wallpaper = eDP-1,${wallpaper}
  '';

  # Start hyprpaper deamon
  systemd.user.services.hyprpaper = {
    Unit = {
      Description = "Wayland wallpaper daemon";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${lib.getExe pkgs.hyprpaper}";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}

