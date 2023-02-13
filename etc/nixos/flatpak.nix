{ config, pkgs, ... }:

{

  # Enable Flatpak
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-kde
      ];
    };
  };
}
