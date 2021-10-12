let
  sources = import ./nix/sources.nix { inherit pkgs; };

  haskellNix = import sources."haskell.nix" {};

  nixpkgs = haskellNix.sources.nixpkgs-unstable;

  pkgs = import nixpkgs {};
in

with pkgs;

mkShell rec {
  name = "some-env";

  libs = [ ncurses ];

  # This does not fail
  nobuildPhase = "echo ${lib.makeLibraryPath libs}";

  # This DOES fail
  LD_LIBRARY_PATH = lib.makeLibraryPath libs;
}
