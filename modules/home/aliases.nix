{
  programs.fish = {
    enable = true;

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
      phone = ''
        set mnt (find /run/user/(id -u)/gvfs -maxdepth 1 -type d -name 'mtp:host=*' 2>/dev/null | head -n1)

        if test -z "$mnt"
          set vol (gio mount -li 2>/dev/null | grep -oP 'activation_root=\Kmtp://\S+' | head -n1)
          if test -z "$vol"
            echo "Телефон не найден. Проверь USB-кабель и режим 'Передача файлов' на телефоне."
            return 1
          end
          gio mount "$vol"
          set mnt (find /run/user/(id -u)/gvfs -maxdepth 1 -type d -name 'mtp:host=*' 2>/dev/null | head -n1)
        end

        if test -z "$mnt"
          echo "Не удалось смонтировать телефон."
          return 1
        end

        y "$mnt"
      '';
    };
  };
}
