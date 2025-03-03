{
  description = "AlgoTeX flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
    tuda-logo = {
      url = "https://upload.wikimedia.org/wikipedia/de/2/24/TU_Darmstadt_Logo.svg";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      tuda-logo,
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      # shell for using algotex
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.python313Packages.pygments
          self.packages.${system}.latex_with_algotex
        ];
      };

      packages.${system} = {
        algotex = pkgs.stdenvNoCC.mkDerivation (finalAttrs: {
          name = "algotex";
          src = ./.;
          passthru = {
            pkgs = [ finalAttrs.finalPackage ];
            tlType = "run";
            tlDeps = with pkgs.texlive; [ latex ];
          };
          nativeBuildInputs = with pkgs; [ librsvg ];
          installPhase = ''
            runHook preInstall

            algotex_path=$out/tex/latex/algotex
            mkdir -p $algotex_path
            cp $src/tex/* $algotex_path/

            logo_path=$out/tex/latex/local
            mkdir -p $logo_path
            rsvg-convert -f pdf -o $logo_path/tuda_logo.pdf ${tuda-logo}

            runHook postInstall
          '';
          dontConfigure = true;
          dontBuild = true;
        });

        latex_with_algotex = pkgs.texlive.combine {
          inherit (pkgs.texlive) scheme-full;
          inherit (self.packages.${system}) algotex;
        };

        default = self.packages.${system}.latex_with_algotex;
      };
    };
}
