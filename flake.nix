{
  description = "System Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    dwm.url = "github:Kaixi26/dwm/main";
    dwm.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
      overlays = [
        (final: prev: {
          dwm = inputs.dwm.defaultPackage.${system};
        })
      ];
    };

    lib = nixpkgs.lib;

  in {
    homeManagerConfigurations = {
      work = home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;
	      username = "work";
	      homeDirectory = "/home/work";
	      stateVersion = "22.05";
	      configuration = {
	        imports = [
	          ./user-modules
	        ];
	      };
      };
      kaixi = home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;
	      username = "kaixi";
	      homeDirectory = "/home/kaixi";
	      stateVersion = "22.05";
	      configuration = {
	        imports = [
	          ./user-modules
	        ];
	      };
      };
    };

    nixosConfigurations = {
      jupiter = lib.nixosSystem {
        inherit system pkgs;
        specialArgs = { inherit inputs; };
	      modules = [
	        ./configuration.nix
          ./system-modules/hardware/jupiter.nix
          { networking.hostName = "jupiter"; }
	      ];
      };
      uranus = lib.nixosSystem {
        inherit system pkgs;
        specialArgs = { inherit inputs; };
	      modules = [
          ./configuration.nix
          ./system-modules/hardware/kaixi.nix
          { networking.hostName = "uranus"; }
	      ];
      };
    };
  };
}
