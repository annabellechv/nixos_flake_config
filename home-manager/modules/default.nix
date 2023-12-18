{ pkgs, ... }:
{
  imports = [
    ./fish
    ./git
    ./hyprland
    ./kitty
    ./nvim
    ./rofi
    ./starship
    ./swaylock
    ./waybar
  ];

  home.packages = with pkgs; [
    # Overview
    btop
    neofetch

    # Tools
    arandr
    pavucontrol
    light
    tree
    tldr
    man-pages
    xfce.thunar

    discord

    # Fonts
    font-awesome
    fira-code
    fira-code-symbols
    material-design-icons

    # Code
    vscode
  ];

}
