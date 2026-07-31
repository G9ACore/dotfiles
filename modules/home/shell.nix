{ ... }:
{
  programs.fish.enable = true;
  programs.starship.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
