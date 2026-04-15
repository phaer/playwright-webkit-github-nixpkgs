{
  description = "playwright + webkit + github action experiment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      forEachSystem =
        f:
        nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            pkgs = import nixpkgs {
              inherit system;
            };
          }
        );
    in
    {
      devShells = forEachSystem (
        { pkgs }:
        {
          default = pkgs.mkShell {
            buildInputs = [
              pkgs.nodejs_25
              pkgs.nil
              pkgs.pnpm
              pkgs.playwright-test
              pkgs.playwright-driver.browsers
            ];
            PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
            PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD = 1;
            PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = 1;
            LIBGL_ALWAYS_SOFTWARE=1;
          };
        }
      );
    };
}
