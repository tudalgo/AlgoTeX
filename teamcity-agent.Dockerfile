FROM jetbrains/teamcity-agent:2024.03.1

USER root

RUN apt-get update && \
  # basic utilities for TeX Live installation
  apt-get install -qy --no-install-recommends curl git unzip wget \
  # miscellaneous dependencies for TeX Live tools
  make fontconfig perl default-jre libgetopt-long-descriptive-perl \
  libdigest-perl-md5-perl libncurses6 \
  # for latexindent (see #13)
  libunicode-linebreak-perl libfile-homedir-perl libyaml-tiny-perl \
  # for eps conversion (see #14)
  ghostscript \
  # for metafont (see #24)
  libsm6 \
  python3 \
  # for gnuplot backend of pgfplots (see !13)
  gnuplot-nox \
  # algotex stuff
  librsvg2-bin nodejs imagemagick && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/apt/ && \
  # bad fix for python handling
  ln -s /usr/bin/python3 /usr/bin/python

# Install newer version of pygments

RUN git clone https://github.com/pygments/pygments
WORKDIR pygments
RUN pip install -e .

# Install TeX Live

RUN mkdir /tmp/install-tex-live
WORKDIR /tmp/install-tex-live

RUN wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
RUN tar -xzf install-tl-unx.tar.gz
RUN rm install-tl-unx.tar.gz
RUN mv install-tl-* install-tl
WORKDIR install-tl
RUN perl ./install-tl --no-interaction --scheme=full --no-doc-install --no-src-install

ENV PATH="${PATH}:/usr/local/texlive/2023/bin/x86_64-linux"

# Install AlgoTeX

RUN sed -i "s/rights=\"none\" pattern=\"PDF\"/rights=\"read|write\" pattern=\"PDF\"/" /etc/ImageMagick-6/policy.xml
RUN sed -i "s/rights=\"none\" pattern=\"PS\"/rights=\"read|write\" pattern=\"PS\"/" /etc/ImageMagick-6/policy.xml
RUN sed -i "s/rights=\"none\" pattern=\"SVG\"/rights=\"read|write\" pattern=\"SVG\"/" /etc/ImageMagick-6/policy.xml
RUN mkdir -p "$(kpsewhich -var-value=TEXMFDIST)/tex/latex/local" \
    && curl -o tuda_logo.svg -L https://upload.wikimedia.org/wikipedia/de/2/24/TU_Darmstadt_Logo.svg\?download \
    && rsvg-convert -f pdf -o tuda_logo.pdf tuda_logo.svg \
    && mv tuda_logo.pdf "$(kpsewhich -var-value=TEXMFDIST)/tex/latex/local" \
    && texhash --verbose
# Install AlgoTeX
WORKDIR /AlgoTeX
COPY . .
RUN l3build install --full
WORKDIR /
