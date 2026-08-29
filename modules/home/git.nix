{...}: {
  programs.git = {
    enable = true;

    settings = {
      user.name = "G9ACore";
      user.email = "dlitvin3120@gmail.com";
    };
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        identityFile = "~/.ssh/id_ed25519"; # Путь к вашему SSH-ключу
      };
    };
  };
}
