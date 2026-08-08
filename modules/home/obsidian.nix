{ pkgs, ... }:
{
  programs.obsidian = {
    enable = true;

    vaults.notes = {
      target = "docs/notes";

      settings = {
        app.legacyChat = false;
	appearance = {
	  baseFontSize = 16;
          accentColor = "#A1B2C3";

	  interfaceFontFamily = "Inter";
	  textFontFamily = "JetBrainsMono Nerd Font";
	  monospaceFontFamily = "JetBrainsMono Nerd Font";
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
        minimal
      ];
    };
  };
}
