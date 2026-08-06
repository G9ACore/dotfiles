{ pkgs, ... }:
{
  programs.obsidian = {
    enable = true;

    vaults.notes.target = "docs/Obsidian";

    defaultSettings = {
      app = {
        alwaysUpdateLinks = true;
        spellcheck = true;
      };

      communityPlugins = with pkgs.obsidianPlugins; [
        dataview
      ];

      themes = with pkgs.obsidianThemes; [
        minimal
      ];
    };
  };

  home.file."Obsidian/.obsidian/snippets/custom-font-size.css" = {
    text = ''
      body {
        --font-text-size: 16px;
      }
    '';
  };
}
