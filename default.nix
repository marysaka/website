{ pkgs ? import <nixpkgs> {}, stdenv ? pkgs.stdenv }:

stdenv.mkDerivation {
  name = "mary-zone";
  version = "1.0.0";

  src = ./.;
  nativeBuildInputs = [ pkgs.zola ];

  buildPhase = "zola build";
  installPhase = "cp -r public $out";
}
