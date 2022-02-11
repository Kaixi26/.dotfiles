{
  description = "System Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
    
    lib = nixpkgs.lib;

  in {
    homeManagerConfigurations = {
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
        inherit system;
	      modules = [
	        ./configuration.nix
          ./system-modules/hardware/jupiter.nix
          { networking.hostName = "jupiter"; }
	      ];
      };
      uranus = lib.nixosSystem {
        inherit system;
	      modules = [
          #./test/configuration.nix
          #./test/hardware-configuration.nix
          ./configuration.nix
          ./system-modules/hardware/kaixi.nix
          { networking.hostName = "uranus"; }
	      ];
      };
    };
  };
}
