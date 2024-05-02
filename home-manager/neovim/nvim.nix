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
  };
}
