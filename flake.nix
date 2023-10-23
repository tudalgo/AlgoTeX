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

            mkdir -p $out/tex/latex/local
            rsvg-convert -f pdf -o $out/tex/latex/local/tuda_logo.pdf ${
              builtins.fetchurl {
                url =
                  "https://upload.wikimedia.org/wikipedia/de/2/24/TU_Darmstadt_Logo.svg";
                sha256 =
                  "sha256:0wb2ygg0wzd2ajdzv847xp1qxkx4m1j64p1gdrq4r05klbrddbwl";
              }
            }
          '';
        });
      patched-latex = with pkgs.texlive;
        combine {
          inherit scheme-full;
          inherit algotex;
        };
    in {
      devShells.${system}.default = with pkgs;
        mkShell {
          buildInputs = [
            python311Packages.pygments
            patched-latex
            pre-commit
            python310Packages.editorconfig
          ];
          shellHook = ''
            pre-commit install
          '';
        };
      packages.${system}.default = patched-latex;
    };
}
