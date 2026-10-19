{
  programs.fish = {
    enable = true;

    # python3 уже есть в PATH из nixpkgs — алиас «python = python3» не нужен.

    shellAbbrs = {
      nrs = "sudo nixos-rebuild switch --flake ~/dotfiles#laptop";
      nrb = "sudo nixos-rebuild boot --flake ~/dotfiles#laptop";
      nrt = "sudo nixos-rebuild test --flake ~/dotfiles#laptop";

      # ff = "home-manager switch --flake ~/dotfiles#dmitry";

      gs = "git status";
      gc = "git commit";
      gp = "git push";
    };

    functions = {
      phone.body = builtins.readFile ./config/fish/functions/phone.fish;
      net-ping.body = builtins.readFile ./config/fish/functions/net-ping.fish;
    };
  };
}
