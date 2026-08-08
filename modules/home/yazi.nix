{ ... }:
{
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    settings = {
      opener = {
        edit = [
          {
            block = true;
            run = "nvim \"$@\"";
          }
        ];
      };
    };

    keymap = builtins.fromTOML (builtins.readFile ./config/yazi/keymap.toml);
  };
}
