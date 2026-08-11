{pkgs, ...}: {
  programs.obsidian = {
    enable = true;

    vaults.notes = {
      target = "docs/notes";

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
        dataview
        vim-yank-highlight
      ];

      themes = with pkgs.obsidianThemes; [
        # minimal
        things
      ];
    };
  };
}
