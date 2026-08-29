{pkgs, config, ...}: let
  c = config.lib.stylix.colors.withHashtag;
  render = import ../../lib/mkTemplate.nix;
in {
  programs.obsidian = {
    enable = true;

    vaults.notes = {
      target = "Documents/Notes";

      settings = {
        app.legacyChat = false;
        appearance = {
          baseFontSize = 16;
          accentColor = c.base0D;
	  cssTheme = "Minimal";
	  appearance.enabledCssSnippets = ["stylix"];

          interfaceFontFamily = "Inter";
          textFontFamily = "Inter";
          monospaceFontFamily = "JetBrainsMono Nerd Font Mono";
        };
      };
    };

    defaultSettings = {
      app = {
        alwaysUpdateLinks = true;
        spellcheck = true;
      };

      communityPlugins = with pkgs.obsidianPlugins; [
        # Specific names locate on github of nix-obsidian-extensions flake (in .json)
        dataview
        obsidian-excalidraw-plugin
        obsidian-icon-folder
        obsidian-kanban
        vim-yank-highlight
      ];

      themes = with pkgs.obsidianThemes; [
        minimal
      ];
    };
  };

  home.file."Documents/Notes/.obsidian/snippets/stylix.css".text =
  render ./config/obsidian/stylix.css {
    base00 = c.base00; base01 = c.base01; base03 = c.base03;
    base04 = c.base04; base05 = c.base05; base0D = c.base0D;
  };
}
