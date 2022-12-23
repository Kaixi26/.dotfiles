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
      x86_64-linux = "x86_64-linux";
      aarch64-darwin = "aarch64-darwin";

      mkPkgs = (system:
        import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
          overlays =
            [ (final: prev: { dwm = inputs.dwm.defaultPackage.${system}; }) ];
        });

      lib = nixpkgs.lib;

      mkHome = ({ username, system }:
        let
          homeBase = if system == x86_64-linux then
            "/home/"
          else if system == aarch64-darwin then
            "/Users/"
          else
            throw "Unknown system '${system}'";
        in {
          home = {
            inherit username;
            homeDirectory = homeBase + username;
            stateVersion = "22.05";
          };
        });

    in {
      homeManagerConfigurations.kaixi =
        home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs x86_64-linux;
          modules = [
            ./user-modules/kaixi.nix
            (mkHome {
              username = "kaixi";
              system = x86_64-linux;
            })
          ];
        };

      homeManagerConfigurations.work =
        home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs aarch64-darwin;
          modules = [
            ./user-modules/work.nix
            (mkHome {
              username = "sf00347";
              system = aarch64-darwin;
            })
          ];
        };

      nixosConfigurations = let
        system = x86_64-linux;
        pkgs = mkPkgs system;
      in {
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
