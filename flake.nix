{
  description = "HS dev environment";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.hubspot-cli.url = "github:m-roll/hubspot-cli-flake";

  outputs = { self, nixpkgs, flake-utils, hubspot-cli }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs' =
          nixpkgs.legacyPackages.${system}.extend hubspot-cli.overlays.default;
      in {
        devShells.default = pkgs'.mkShell {
          packages = [ pkgs'.hubspot-cli pkgs'.nodePackages.localtunnel ];
        };
      });
}

