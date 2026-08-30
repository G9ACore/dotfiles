# dotfiles

NixOS + Home Manager + niri, конфиг под flakes.

## Быстрый старт
1. Пишешь `nix shell -p git --run "git clone https://github.com/G9ACore/dotfiles.git ~/dotfiles"`
2. Пишешь `sudo mv /etc/hardware-configuration.nix ~/dotfiles/hosts/laptop/hardware.nix`
3. Меняешь `lib/setting.nix` на своё усмотрение
4. Билдишь `sudo nixos-rebuild switch --flake ~/dotfiles#laptop`

P.S. Какие-то шаги могут быть неточными/неверными

## Алиасы/кастомные команды
    nrs   # sudo nixos-rebuild switch --flake ~/dotfiles#laptop
    nrb   # ... boot
    nrt   # ... test

## Структура
- `hosts/<name>/` — конкретная машина (hardware.nix генерируется, не трогать руками)
- `modules/nixos/` — системный уровень
- `modules/home/` — Home Manager уровень, один модуль = одна программа/забота
- `users/` — профили (main.nix / guest.nix)
- `lib/` — settings.nix (константы), terminals.nix (реестр терминалов),
 mkHost.nix (сборка nixosSystem), mkTemplate (шаблон для замены повторяющейся логики)
- `assets/` — обои
- `secrets/` — agenix, публичные ключи в secrets.nix

## Конвенции
- Цвета берутся ТОЛЬКО из темы, прописанной в `stylix.theme`, руками хекс не хардкодить.
- Терминал переключается через `lib/settings.nix` (`terminal = "foot";`),
  весь код читает его через `terminals.${settings.terminal}`, а не хардкодит имя бинаря.
- Для файлов, требующих подстановки переменных (@var@), используется `lib/mkTemplate.nix`.

## TODO
- Вынести bluetooth в отдельный модуль (hosts/laptop/default.nix)
- Разложить wayland.nix по категориям (modules/home/wayland.nix)
- Заменой импортировать цвета в файле (modules/home/config/niri/config.kdl)
- Унифицировать, сделать больше поояснительных комментариев
- Настроить другого хоста/юзера
- Добавить больше настроек (lib/settings.nix)
- Добавить механизм смены пароля при первом запуске
