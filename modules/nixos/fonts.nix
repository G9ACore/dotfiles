{ pkgs, ... }: 
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.noto
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      inter
    ];
    fontconfig.defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font Mono" ];
      sansSerif = [ "Inter" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
