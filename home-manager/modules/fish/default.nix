{ pkgs, ... }:
{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      ${pkgs.starship}/bin/starship init fish | source
    '';

    shellAliases = {
      ma = "export PAGER='most' & man";

      nix-shell = "nix-shell --command \"fish\"";

      hm = "cd ~/.setup/home-manager";

      mkdir = "mkdir -p";
      tree = "tree -C";
    };

    shellAbbrs = {
      ns = "nix-shell";

      nrs = "sudo nixos-rebuild switch --flake ~/.setup/#dell-laptop";

      poweroff = "systemctl poweroff";
      reboot = "systemctl reboot";
    };
  };
}
