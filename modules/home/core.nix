{ config, pkgs, ... }:
{
  # Базовые пользовательские пакеты
  home.packages = with pkgs; [
    # Утилиты
    ripgrep      # rg — быстрый grep
    fd           # быстрый find
    bat          # cat с подсветкой
    eza          # ls с иконками
    fzf          # fuzzy finder
    zoxide       # умный cd
    yazi         # файловый менеджер в терминале
    btop         # красивый htop
    fastfetch    # системная информация

    # Архивы
    p7zip
    unrar

    # Сеть
    curl
    wget
    dog          # dig с цветами
  ];

  # XDG директории
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      documents = "${config.home.homeDirectory}/docs";
      download = "${config.home.homeDirectory}/downloads";
      pictures = "${config.home.homeDirectory}/pics";
      # videos = "${config.home.homeDirectory}/videos";
      # music = "${config.home.homeDirectory}/music";
      # desktop = "${config.home.homeDirectory}/desktop";
    };
  };

  # Git
  programs.git = {
    enable = true;
    userName = "G9ACore";
    userEmail = "dlitvin3120@email.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };

  # Neovim с интеграцией nix для настройки
  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
    plugins = {
      lsp.enable = true;
      telescope.enable = true;
      treesitter.enable = true;
      oil.enable = true;  # файловый менеджер
    };
  };

  # Разрешить Home Manager управлять собой
  programs.home-manager.enable = true;
}