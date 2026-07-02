{ pkgs, ... }:
{
  # Kitty — терминал
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      window_padding_width = 8;
      hide_window_decorations = "yes";
      background_opacity = "0.95";
    };
    # Цвета подтянет Stylix автоматически
  };

  # Fish — оболочка
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting ""  # Убрать приветствие
      zoxide init fish | source
    '';
    shellAliases = {
      ls  = "eza --icons";
      ll  = "eza -la --icons";
      lt  = "eza --tree --icons";
      cat = "bat";
      cd  = "z";    # zoxide
      rebuild = "sudo nixos-rebuild switch --flake ~/dotfiles#(hostname)";
      hm  = "home-manager switch --flake ~/dotfiles#main@(hostname)";
      v   = "nvim";
    };
  };

  # Starship — промпт
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = false;
      format = "$directory$git_branch$git_status$nix_shell$character";
      directory.style = "bold blue";
      git_branch.style = "bold purple";
      nix_shell.symbol = "❄️ ";
    };
  };

  # fzf интеграция
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };
}