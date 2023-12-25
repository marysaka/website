{
  description = "mary.zone nix flake";

  inputs.nixpkgs.url = "nixpkgs/nixos-23.11";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
  flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = import nixpkgs {
      inherit system;
      overlays = [ self.overlay."${system}" ];
    };
  in
  {

    defaultPackage = self.packages."${system}".mary_zone;
    packages.mary_zone = pkgs.mary_zone;

    overlay = final: prev: {

      mary_zone = with final; stdenv.mkDerivation {
        name = "mary-zone";
        version = "1.0.0";

        src = ./.;
        nativeBuildInputs = [ pkgs.zola ];

        buildPhase = "zola build";
        installPhase = "cp -r public $out";
      };
    };

  });
}
