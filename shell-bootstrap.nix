let
  sources = import ./nix/sources.nix { inherit pkgs; };

  pkgs = import sources."nixpkgs" {};
in

with pkgs;

mkShell rec {
  name = "test-env";

  buildInputs = [ nix_2_4 ];
}
