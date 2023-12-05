{ pkgs, lib, ... }:
{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    
    settings = {
      shell = ''
        ${lib.getExe pkgs.fish} --init-command "echo; ${lib.getExe pkgs.neofetch} --disable packages; echo"
      '';

      background_opacity = "0.75";

      font_family = "Fira Code";
      font_size = "11";

      confirm_os_window_close = "0";
    };
  };
}
