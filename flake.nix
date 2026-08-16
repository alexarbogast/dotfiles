{
  description = "Home manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    my-nvchad-config = {
      url = "path:./nvim";
      flake = false;
    };

    nix4nvchad = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nvchad-starter.follows = "my-nvchad-config"; # Overrides the starter
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nix4nvchad,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations = {
        alex-home = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            ./home.nix
            nix4nvchad.homeManagerModules.default
            {
              home.username = "alex";
              home.homeDirectory = "/home/alex";
            }
          ];
        };

        owa-home = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            ./home.nix
            nix4nvchad.homeManagerModules.default
            {
              home.username = "owa";
              home.homeDirectory = "/home/owa";
            }
          ];
        };
      };
    };
}
