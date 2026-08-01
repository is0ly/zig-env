{
  description = "Zig dev environments, one per toolchain version";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    zig-overlay = {
      url = "github:mitchellh/zig-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zls = {
      url = "github:zigtools/zls";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      zig-overlay,
      zls,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      zigs = zig-overlay.packages.${system};

      mkZigShell =
        zig:
        pkgs.mkShell {
          packages = [
            zig
            zls.packages.${system}.default
          ];

          shellHook = ''
            echo "zig $(zig version)"
          '';
        };
    in
    {
      # Одна оболочка на каждую версию из zig-overlay:
      #   nix develop github:is0ly/zig-env#master
      #   nix develop github:is0ly/zig-env#"0.16.0"
      devShells.${system} = (builtins.mapAttrs (_name: zig: mkZigShell zig) zigs) // {
        default = mkZigShell zigs.master;
      };
    };
}
