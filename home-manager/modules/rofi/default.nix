{ pkgs, config, ... }:
{
  programs.rofi = {
    enable = true;
    theme = ./round.rasi;
  };
}
