{ config, pkgs, lib, inputs, user, ... }:

{
  imports = [
    ./modules
  ];

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "23.05";
  };

  programs.home-manager.enable = true;
}
