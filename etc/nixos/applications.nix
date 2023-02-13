# https://nixos.wiki/wiki/Firewall
{ config, pkgs, ... }:

{

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
}
