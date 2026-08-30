{
  # Позволяет не засыпать компьютера, когда подключён к розетке
  services.logind.settings.Login = {
    HandleLidSwitchExternalPower = "ignore";
  };
}
