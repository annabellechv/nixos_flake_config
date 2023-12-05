{ pkgs, ... }:
{
  programs.starship = {
    enable = true;

    settings = {
        add_newline = false;
        format = "$jobs$directory$git_branch$git_state$git_metrics$git_status$cmd_duration $battery$status$character";
        right_format = "$nix_shell";

        jobs = {
            format = "[$symbol$number]($style) ";
            style = "bold blue";
            symbol = "✦ ";
            number_threshold = 2;
        };

        directory = {
            format = "[$path]($style)";
            style = "bold cyan";
            truncation_length = 10;
            truncate_to_repo = false;
            repo_root_format = "[$before_root_path](cyan)[$repo_root]($repo_root_style)[$path](cyan)";
            repo_root_style = "bold cyan";
        };

        git_branch = {
            format = " on [$symbol$branch]($style)";
            style = "bold purple";
            symbol = " ";
        };

        git_metrics = {
            format = " [+$added]($added_style)/[-$deleted]($deleted_style)";
            added_style = "bold green";
            deleted_style = "bold red";
        };

        git_status = {
            format = "[ \\[$ahead_behind$all_status\\]]($style)";
            style = "red";
            conflicted = "=";
            ahead = "⇡";
            behind = "⇣";
            diverged = "⇕";
            up_to_date = "✓";
            untracked = "?";
            stashed = "$";
            modified = "!";
            staged = "+";
            renamed = "»";
            deleted = "✘";
        };

        nix_shell = {
            format = "[$name]($style)";
            style = "blue";
        };

        cmd_duration = {
            format = " [took $duration]($style)";
            style = "yellow";
            show_milliseconds = false;
            min_time = 2000;
        };

        status = {
            format = " $status";
            disabled = false;
        };

        character = {
            format = "
[┌──────────────────────────────────────────────](blue)
[└─>](blue) ";
        };
      };
  };
}
