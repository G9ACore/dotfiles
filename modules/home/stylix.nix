{
  stylix.targets = {
    # Если хотите сами управлять темами иконок/GTK — поставьте gtk.enable = false.
    # Пока включено — stylix через mkForce ставит СВОЮ перегенерированную тему
    # иконок, и gtk.iconTheme в gtk.nix применяться НЕ будет (поэтому Papirus
    # «не сработал»). DMS-оболочка при этом берёт иконки трея из GTK-темы системы.
    gtk.enable = true;
    qt.enable = true;

    zen-browser.profileNames = ["default"];
  };
}
