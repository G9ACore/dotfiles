{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.noctalia.packages.${pkgs.system}.default
  ];

  home-manager.sharedModules = [ inputs.noctalia.homeModules.default ];

  programs.noctalia-shell = {
    enable = true;

    settings = {
      # Какие плагины активны
      plugins.activePlugins = [
        { id = "bar"; active = true; }
        { id = "overview"; active = true; }
        { id = "launcher"; active = true; }
        { id = "notifications"; active = true; }
      ];

      # Шаблоны для приложений (синхронизация цветов)
      templates.activeTemplates = [
        { id = "kitty"; active = true; }
      ];
    };
  };
}