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
  };
}
