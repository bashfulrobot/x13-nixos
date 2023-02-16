# /etc/nixos/flake.nix

{
  description = "Configure X13 Yoga";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, nixos-hardware }: {
    # replace <your-hostname> (nix13) with your actual hostname
    nixosConfigurations.nix13 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      # ...
      modules = [
        # ...
        # add your model from this list: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
        nixos-hardware.nixosModules.lenovo-thinkpad-x13-yoga
        ./configuration.nix
      ];
    };
  };
}
