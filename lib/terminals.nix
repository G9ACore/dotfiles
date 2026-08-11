# ~/dotfiles/lib/terminals.nix
# Реестр поддерживаемых терминалов: как называется пакет в nixpkgs,
# и как у него правильно вызвать "открыть терминал и выполнить команду"
# (у alacritty/wezterm/foot этот синтаксис разный).
#
# Использование (в модуле, где нужен terminalCmd = "alacritty"):
#   terminals = import ../../lib/terminals.nix;
#   t = terminals.${settings.terminal};
#   # t.package -> pkgs.alacritty (передавать pkgs снаружи, см. ниже)
#   # t.exec "yazi"  -> "alacritty -e yazi"
#   # t.execArgs ["yazi"] -> [ "alacritty" "-e" "yazi" ]  (для niri spawn)
{
  alacritty = {
    prefix = "alacritty";
    bin = "alacritty";
    # execArgs: список аргументов для niri `spawn "..." "..." ...;`
    execArgs = cmdArgs: ["alacritty" "-e"] ++ cmdArgs;
    # exec: одна строка для .ini/.sh файлов (fuzzel `terminal=`, шелл-скрипты)
    exec = cmdStr: "alacritty -e ${cmdStr}";
  };

  wezterm = {
    prefix = "wezterm";
    bin = "wezterm";
    execArgs = cmdArgs: ["wezterm" "start" "--"] ++ cmdArgs;
    exec = cmdStr: "wezterm start -- ${cmdStr}";
  };

  foot = {
    prefix = "foot";
    bin = "foot";
    execArgs = cmdArgs: ["foot"] ++ cmdArgs;
    exec = cmdStr: "foot ${cmdStr}";
  };
}
