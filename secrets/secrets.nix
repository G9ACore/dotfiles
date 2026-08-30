let
  dmitry = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINC8Mlo7Sy/HkGBUha0PvDIOuvVNbuPtc+0dZIYeJPHX dlitvin3120@gmail.com";
  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGxZeJ9/MgrNff6iSYT2eR2NmxToPKfRQDaxQJw2JyYK root@G9ACore";
in {
  "dmitry-password.age".publicKeys = [dmitry system];
}
