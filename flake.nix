{
  description = "AlgoTeX flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
    tuda-pdf = {
      url = "https://www.tu-darmstadt.de/media/medien_stabsstelle_km/services/medien_cd/das_bild_der_tu_darmstadt.pdf";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      tuda-pdf,
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      # minimal example shell for using algotex
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.python313Packages.pygments
          self.packages.${system}.latex_with_algotex
        ];
      };

      packages.${system} = {
        # algotex and logo only
        algotex = pkgs.stdenvNoCC.mkDerivation (finalAttrs: {
          name = "algotex";
          src = ./.;
          passthru = {
            pkgs = [ finalAttrs.finalPackage ];
            tlType = "run";
            tlDeps = with pkgs.texlive; [ latex ];
          };
          nativeBuildInputs = with pkgs; [
            inkscape
            librsvg
          ];
          installPhase = ''
            runHook preInstall

            # copy algotex files
            algotex_path=$out/tex/latex/algotex
            mkdir -p $algotex_path
            cp $src/tex/* $algotex_path/

            # build tuda logo
            logo_path=$out/tex/latex/local
            mkdir -p $logo_path
            cp ${tuda-pdf} tuda.pdf

            # see https://github.com/tudalgo/AlgoTeX/blob/5de6300bcbbf4ffb5c6ec9e8fb29fdd2f3b7896b/Dockerfile.logo
            inkscape tuda.pdf --export-filename=p1_i.svg --export-dpi=3000 --pages=1
            sed -i 's/icc-color([^)]*)//g' p1_i.svg
            sed -i 's/#000000/#1d1d1bff/g' p1_i.svg
            rsvg-convert -f pdf -o $logo_path/tuda_logo.pdf p1_i.svg --export-id=g23

            runHook postInstall
          '';
          dontConfigure = true;
          dontBuild = true;
        });

        # full texlive distribution with algotex and the logo file
        latex_with_algotex = pkgs.texlive.combine {
          inherit (pkgs.texlive) scheme-full;
          inherit (self.packages.${system}) algotex;
        };

        default = self.packages.${system}.latex_with_algotex;
      };
    };
}
