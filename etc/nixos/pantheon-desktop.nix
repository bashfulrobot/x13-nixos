{ config, pkgs, ... }:

{

  # Install pantheon-tweaks at the system level packages
  environment.systemPackages = with pkgs; [ pantheon-tweaks ];

  # Enable the Pantheon Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.pantheon.enable = true;

  # Enable pantheon tweaks in settings
  programs.pantheon-tweaks.enable = true;
}
