{
  description = "A Nix-flake-based Node.js development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
    in
    {
      devShells."${system}".default =
        let
          pkgs = import nixpkgs {
            inherit system;
          };
        in
        pkgs.mkShell {
          packages = with pkgs; [
            nodejs
            nodePackages_latest.pnpm
            nodePackages_latest.typescript
            nodePackages_latest.eslint
          ];

          shellHook = ''
            exec fish
            echo "node `${pkgs.nodejs}/bin/node --version`"
          '';
        };
    };
}
