{ pkgs, lib, ... }:
{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    settings = {
      shell = ''
        ${lib.getExe pkgs.fish} --init-command "echo; ${lib.getExe pkgs.neofetch} --disable packages; echo"
      '';
    };
  };
}
