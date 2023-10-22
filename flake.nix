{
  description = "AlgoTeX flake";

  outputs = { self, nixpkgs, }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      algotex = with pkgs;
        stdenvNoCC.mkDerivation (finalAttrs: {
          name = "algotex";
          src = fetchFromGitHub {
            owner = "tudalgo";
            repo = "AlgoTeX";
            rev = "5f0d8bd394bba5b04eef0d11614b3cadd315f1c8";
            hash = "sha256-hpuPeK1xj62xveMBh8X1NvRKgtRTSUBZk5eOPixxIpY=";
          };
          passthru = {
            pkgs = [ finalAttrs.finalPackage ];
            tlType = "run";
            tlDeps = with texlive; [ latex ];
          };
          installPhase = ''
            mkdir -p $out/tex/latex/algotex
            cp -t $out/tex/latex/algotex/ $src/tex/*
            cp $out/tex/latex/algotex/FOPBot.sty $out/tex/latex/algotex/fopbot.sty
          '';
        });
      patched-latex = with pkgs.texlive;
        combine {
          inherit scheme-full;
          inherit algotex;
        };
    in {
      devShells.${system}.default = with pkgs;
        mkShell { buildInputs = [ python311Packages.pygments patched-latex ]; };
      packages.${system}.default = patched-latex;
    };
}
