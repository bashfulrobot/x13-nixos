# https://nixos.wiki/wiki/Firewall
{ config, pkgs, ... }:

{

  # Enable the firewall
  networking.firewall = {
    enable = true;
    # Allow SSH
    allowedTCPPorts = [ 22 ];
    # Sample with multiple ports
    # allowedTCPPorts = [ 80 443 ];
    # Sample with a range of ports
    # allowedUDPPortRanges = [
    #   { from = 4000; to = 4007; }
    #   { from = 8000; to = 8010; }
    # ];
  };

  # Sample binding to an interface
  # networking.firewall.interfaces."eth0".allowedTCPPorts = [ 80 443 ];

}
