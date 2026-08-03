{ ... }:
{
  programs.obsidian = {
    enable = true;

    vaults.notes.target = "docs/Obsidian";

    defaultSettings.app = {
      alwaysUpdateLinks = true;
      spellcheck = true;
    };
  };
}
