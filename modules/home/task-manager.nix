{pkgs, lib, ...}: {
  programs.btop = {
    enable = true;
    package = pkgs.btop.override { cudaSupport = true; };

    settings = {
      color_theme = lib.mkForce "Default";
      theme_background = lib.mkForce false;   # прозрачный фон — использует фон терминала
      truecolor = lib.mkForce true;

      gpu_mirror_support = true;
      shown_gpu = "0";
      temp_scale = "celsius";
    };
  };
}
