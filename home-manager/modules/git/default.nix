{ pkgs, ...}:
{
  home.packages = with pkgs; [
    gitAndTools.gitflow
  ];

  programs.git = {
    enable = true;

    # User configuration
    userName = "Annabelle Chevreau";
    userEmail = "annabelle" + "." + "chevreau" + "@gmail.com";

    ignores = [ "*.swp" ];

    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
      pull.rebase = true;
    };

    # Aliases
    aliases = {
      gs = "git status";
      ga = "git add";
      gaa = "git add .";
      gc = "git commit -m";
      gp = "git push";
    };
  };
}
