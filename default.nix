{
  sources ? import ./npins,
  pkgs ? import sources.nixpkgs { },
}:
let
  bmad-method = pkgs.callPackage ./nix/bmad-method.nix {
    src = sources."bmad-method";
  };
in
{
  inherit bmad-method;

  shell = pkgs.mkShell {
    NIX_PATH = "nixpkgs=${sources.nixpkgs}";

    packages = with pkgs; [
      bash
      bash-language-server
      bmad-method
      coreutils
      direnv
      findutils
      git
      jq
      marksman
      nix
      nixd
      nixfmt
      nodejs
      npins
      ripgrep
      shellcheck
      spec-kit
      taplo
      uv
      vscode-langservers-extracted
      yaml-language-server
    ];
  };
}
