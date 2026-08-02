{ ... }:
{
  programs.yazi = {
    enable = true;
    settings.yazi = {
      opener.edit = [
        {
          run = "nvim \"$@\"";
          block = true;
        }
      ];
    };
  };
}
