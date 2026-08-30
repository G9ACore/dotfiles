{
  primaryUser = "dmitry";
  timeZone = "Asia/Anadyr";

  # alacritty | wezterm | foot — см. lib/terminals.nix
  terminal = "foot";

  # Настройка wlsunset для автоматического изменения якрости/температуры дисплея
  wlsnt = {
    latitude = "64.4"; # Широта
    longitude = "173.2"; # Долгота

    day_t = "6500"; # Температура дисплея днём
    night_t = "4000"; # Температура дисплея ночью
  };
}
