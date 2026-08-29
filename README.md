# dotfiles

NixOS + Home Manager + niri, конфиг под flakes.

## Быстрый старт
    nrs   # sudo nixos-rebuild switch --flake ~/dotfiles#laptop
    nrb   # ... boot
    nrt   # ... test

## Структура
- `hosts/<name>/` — конкретная машина (hardware.nix генерируется, не трогать руками)
- `modules/nixos/` — системный уровень
- `modules/home/` — Home Manager уровень, один модуль = одна программа/забота
- `users/` — профили (main.nix / guest.nix)
- `lib/` — settings.nix (константы), terminals.nix (реестр терминалов),
 mkHost.nix (сборка nixosSystem)
- `assets/` — обои, base16-matugen.yaml (источник для stylix)
- `secrets/` — agenix, публичные ключи в secrets.nix

## Конвенции
- Цвета берутся ТОЛЬКО из `assets/base16-matugen.nix`, руками хекс не хардкодить.
- Терминал переключается через `lib/settings.nix` (`terminal = "foot";`),
  весь код читает его через `terminals.${settings.terminal}`, а не хардкодит имя бинаря.
- Для файлов, требующих подстановки переменных (@var@), используется `lib/mkTemplate.nix`.

## TODO
- вынести bluetooth в отдельный модуль (hosts/laptop/default.nix)
- разложить wayland.nix по категориям (modules/home/wayland.nix)
- свести все цвета к палитре + заменой импортировать их в файле (modules/home/config/niri/config.kdl)
- привести ко одному виду комментарии
- написать больше пояснительных комментариев
- настроить другого хоста/юзера
