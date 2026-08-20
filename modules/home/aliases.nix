{
  programs.fish = {
    enable = true;

    shellAliases = {
      python = "python3";
    };

    shellAbbrs = {
      nrs = "sudo nixos-rebuild switch --flake ~/dotfiles#laptop";
      # nrsvm = "nixos-rebuild switch --flake ~/dotfiles#vm";
      nrb = "sudo nixos-rebuild boot --flake ~/dotfiles#laptop";
      nrt = "sudo nixos-rebuild test --flake ~/dotfiles#laptop";

      # ff = "home-manager switch --flake ~/dotfiles#dmitry";

      gs = "git status";
      gc = "git commit";
      gp = "git push";
    };

    functions = {
      phone.body = builtins.readFile ./config/fish/functions/phone.fish;
      driveoff.body = builtins.readFile ./config/fish/functions/driveoff.fish;
      driveon.body = builtins.readFile ./config/fish/functions/driveon.fish;
    };
  };
}
