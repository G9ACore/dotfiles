{pkgs, ...}: {
  programs.obsidian = {
    enable = true;

    vaults.notes = {
      target = "docs/Notes";

      settings = {
        app.legacyChat = false;
        appearance = {
          baseFontSize = 16;
          accentColor = "#b0c6ff";

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
}
