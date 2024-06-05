{ ... }:
{
  programs.firefox = {
    enable = true;
    arkenfox = {
      enable = true;
      version = "master";
    };

    profiles.Default.arkenfox = {
      enable = true;
    };
  };
}
