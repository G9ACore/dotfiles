{ ... }:
{
  programs.obsidian = {
    enable = true;

    vault.notes.target = "docs/Obsidian";

    defaultSettings.app = {
      alwaysUpdateLinks = true;
      spellcheck = true;
    };
  };
}
