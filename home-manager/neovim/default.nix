{
  pkgs,
  config,
  ...
}: {
  # All that is needed because neovim config is a pain
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    package = (
      pkgs.neovim-unwrapped.overrideAttrs {
        pname = "neovim-unwrapped";
        version = "0.10.0";
        src = pkgs.fetchFromGitHub {
          owner = "neovim";
          repo = "neovim";
          rev = "v0.10.0";
          hash = "sha256-FCOipXHkAbkuFw9JjEpOIJ8BkyMkjkI0Dp+SzZ4yZlw=";
        };
      }
    );
  };
}
