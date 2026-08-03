{ pkgs, ... }: 
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      inter
      noto-fonts
      noto-fonts-color-emoji
      colloid-icon-theme
    ];
    fontconfig.defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font Mono" ];
      sansSerif = [ "Inter" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
