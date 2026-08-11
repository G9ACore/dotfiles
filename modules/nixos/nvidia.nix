{
  config,
  lib,
  ...
}: {
  # Загрузка драйверов NVIDIA
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false; # Set to true if you prefer the open-source kernel module
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Enable PRIME Offload
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true; # This provides the 'nvidia-offload' utility
      };

      # Run 'lspci | grep -E "VGA|3D"' to find your exact Bus IDs
      intelBusId = "PCI:00:02:0"; # Replace with your Intel Integrated GPU Bus ID
      nvidiaBusId = "PCI:01:00:0"; # Replace with your Nvidia Dedicated GPU Bus ID
    };
  };
}
