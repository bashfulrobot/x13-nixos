{ config, pkgs, ... }:

{
  # Import other configuration modules
  # (hardware-configuration.nix is autogenerated upon installation)
  # paths in nix expressions are always relative the file which defines them
  imports = [

    # Detected Hardware-configuration
    ./hardware-configuration.nix

    # Firewall configuration
    ./firewall.nix

    # Pantheon configuration
    ./pantheon-desktop.nix

  ];

  ##### Bootloader configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ##### System configuration

  # Set Hostname
  networking.hostName = "nix13"; # Define your hostname
  # Set your time zone.
  time.timeZone = "America/Vancouver";
  # Latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # Configure keymap in X11 / Enter keyboard layout
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  ##### Network configuration
  networking.networkmanager.enable = true;

  ##### Services configuration

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Flatpak
  # services.flatpak.enable = true;

  # Enable firmware updates
  services.fwupd.enable = true;

  # Enable TLP
  services.tlp.enable = true;

  # Enable SSH
  services.openssh = {
    enable = true;
    ports = [ 22 ];
  };

  ##### Nix configuration

  # A recurring problem with NixOS is lack of space on /. Even if you only ocasionally use Nix, it is easy for /nix/store to grow beyond reasonable sizes.
  nix.settings.auto-optimise-store = true;
  # Enable Flakes support
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Garbage collection configuration
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  ##### User configuration

  # Define user accounts
  users.users.dustin = {
    isNormalUser = true;
    description = "Dustin Krysak";
    extraGroups = [ "networkmanager" "wheel" "adm" ];
    hashedPassword =
      "$6$o1C3NFwuzrhf20lS$F2aTa.ueGOr/OJHl7TmW.3wnEPh9HPJy//hIaU8Px/zKgpwl9RheaynAWbGyD13qyhoML.nazGi23M9Q.PpG00";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCi1ukcZU9jVoqmn9+acVwExfw24vAZ53HyQh3VT9aXRYKhLbfMOU2tvRlgIX+znOE4Uc3goFhRB/Qes/NchS6IQf2lfbHBUXoVtzl2gxMfMh49lecoYsv24NtnBLw9QGv/HfhqBR/8ZZbI3vE2XPEEyJDZDTl96iimX/DvxIjRoFowQtfhe4S5zYK7Km6RMEOCWLEt7FApIs1oezylUgGb4k0SAJTOWUT9It8j0BX7ydvPlvKWrJQsVpgw54iyDNj9GiM8qNIt/ziWEAmFj/sqW80lngkXyDJymyan31ijlDvoksEQY+e7BqzA+6IEu0QUCD55NO8ewaRZFTtUTGLIxND/FIR/jir0II0Qnoq4iJWIWls/2G51cKUjc0nkdD+qjXcdaHVJj/1mMxAq7iUWj9RPkKWllYKIV6m1vZV9rBWY++O8JBeSZKofIydNDyUUyx+YCmSOICDYQ2Y0H2W10b+K08OlFeHzzrppePnCN5xw8VlDbhxDLxREJ6t6lYwi1cWOMZ6pj4yJ3i+HcsJVw7V8IB+/QVKmD8SWNi3Ez6He9Thhq4HiqnKOA2FvakClQUZHOuCtT9HQbSOn+30oeF2WHZugpnEaH8hTx1yyyrSzPncc+QbYsxs49w1AREOjZIRUbY5dR4ljx7WxII735yGPCELPBoZIvre/rAr4Jw== dustin@bashfulrobot.com"
    ];
    packages = with pkgs;
      [
        #pantheon-tweaks
      ];
  };

  ##### Enable/Disable hardware

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable Bluetooth
  hardware.bluetooth.enable = true;

  ##### System Packages configuration

  # Allow Unfree packages
  nixpkgs.config.allowUnfree = true;

  # Allow GTK apps to use dconf for settings
  programs.dconf.enable = true;

  # Install system level packages
  environment.systemPackages = with pkgs; [
    wget
    google-chrome
    vscode
    ripgrep
    fd
    curl
    git
    neovim
    _1password
    _1password-gui
    oh-my-posh
    meslo-lgs-nf
    espanso
    zsh
    tilix
    gnumake
    nix-index
    bat
    exa
    dua
    sd
    du-dust
    restic
    autorestic
  ];

  # services.avahi = {
  #   enable = true;
  #   nssmdns = true;
  #   openFirewall = true;
  # };

  ##### System
  system.stateVersion = "22.11";
  system.autoUpgrade.enable = true;

}