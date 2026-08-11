# ~/dotfiles/lib/settings.nix
# Единственный источник правды для "личных" констант конфига:
# имя пользователя, таймзона, выбор терминала и т.п.
#
# Меняешь значение здесь — оно расходится по всем модулям, которые
# его читают через specialArgs.settings (см. lib/mkHost.nix).
#
# ВАЖНО: terminal должен быть валидным ключом из lib/terminals.nix,
# иначе builtins.replaceStrings в местах, где терминал подставляется
# текстом (fuzzel.ini, niri config.kdl, xdg.nix), просто ничего не заменит.
{
  primaryUser = "dmitry";

  timeZone = "Europe/Moscow";

  # alacritty | wezterm | foot — см. lib/terminals.nix
  terminal = "foot";
}
