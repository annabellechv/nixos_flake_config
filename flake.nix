{
  description = "Annabelle's NixOS Flake Configuration";

  inputs =
    {
      nixpkgs-stable.url = "github:nixos/nixpkgs/release-23.05";	# Stable Nix Packages
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";		# Unstable Nix Packages

      home-manager = {							# User Environment Manager
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      hyprland = {
        url = "github:hyprwm/Hyprland";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      
      nixvim = {
        url = "github:nix-community/nixvim";
        inputs.nixpkgs.follows = "nixpkgs";
      };

    };

  outputs = inputs @ { self, nixpkgs, home-manager, hyprland, nixvim, ... }:
    let
      user = "aperitrix";
      location = "$HOME/.setup";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {						# NixOS Configuration
        dell-laptop = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs user; };
          modules = [
            ./hosts/dell-laptop

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs user; };
              home-manager.users.${user} = {
                imports = [
                  hyprland.homeManagerModules.default
                  ./home-manager
                ];
              };
            }
          ];
        };
      };
    };
}
