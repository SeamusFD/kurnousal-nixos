{
  config,
  lib,
  ...
}: {
  options.programs.rust.cargo-leptos = {
    enable = lib.mkEnableOption "cargo-leptos, built tool for Leptos web framework";
    package =
      lib.mkPackageOption config.programs.rust.toolchainPackages "cargo-leptos" {};
  };
}
