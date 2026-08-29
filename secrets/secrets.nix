let
  dmitry = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAd70W/pUzx8V1W37A7H0E0guEBTY1ycpv3c3yPKkaNg dlitvin3120@gmail.com";
  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAd70W/pUzx8V1W37A7H0E0guEBTY1ycpv3c3yPKkaNg root@G9ACore";
in {
  "dmitry-password.age".publicKeys = [dmitry system];
}
