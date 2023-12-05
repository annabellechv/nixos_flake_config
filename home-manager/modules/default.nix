{ pkgs, ... }:
{
  imports = [
    ./fish
    ./git
    ./hyprland
    ./kitty
    ./nvim
    ./swaylock
    ./waybar
  ];

  home.packages = with pkgs; [
    # Overview
    htop
    neofetch

    # Tools
    arandr
    pavucontrol
    tree
    tldr
    man-pages

    discord
  ];

}
