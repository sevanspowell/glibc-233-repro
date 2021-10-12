let
  sources = import ./nix/sources.nix { inherit pkgs; };

  pkgs = import sources."nixpkgs" {};
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
