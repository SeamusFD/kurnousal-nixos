{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "sddm-catppucin-theme";
  src =
    pkgs.fetchFromGitHub
      {
        owner = "TiagoDamascena";
        repo = "sddm-sugar-catppuccin";
        rev = "a7271089a6f990b2df12f34d968a33fb6e3493c9";
        hash = "sha256-Q7J6Jt/3V6ZzFH5lCXewHL+HBeNc1hKEzZE3Hjnw9dQ=";
      };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
  '';
}
