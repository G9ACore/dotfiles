{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        resize-by-cells = "no";
        pad = "12x10 center";
      };
      cursor = {
        style = "block";
        blink = "no";
      };
      mouse.hide-when-typing = "yes";
      scrollback.lines = 10000;
      url.launch = "xdg-open \${url}";
      csd = {
        preferred = "none";
        size = 0;
      };
    };
  };
}
