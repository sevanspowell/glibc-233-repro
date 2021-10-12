let
  sources = import ./nix/sources.nix { inherit pkgs; };

  haskellNix = import sources."haskell.nix" {};

  nixpkgs = haskellNix.sources.nixpkgs-unstable;

  pkgs = import nixpkgs {
    config = haskellNix.nixpkgsArgs.config;
  };
in

with pkgs;

mkShell rec {
  name = "some-env";

  libs = [ ncurses ];

  nobuildPhase = "echo ${lib.makeLibraryPath libs}";

  # Ensure that libz.so and other libraries are available to TH splices.
  LD_LIBRARY_PATH = lib.makeLibraryPath libs;
}
