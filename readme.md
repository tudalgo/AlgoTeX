# FOPTeX - Die LaTeX-Vorlage der FOP und AUD

## Voraussetzungen
- Latex-Installation (z.B. MikTex oder TexLive)
- Installation der [TU-Template](https://github.com/tudace/tuda_latex_templates) und der verwendeten Plugins
- Python-Installation mit pip und dem Plugin `pygments`  - wenn pip installiert ist, kann pygments wie folgt installiert werden:
```sh
pip install pygments
```

Um die volle Funktionalität zu erreichen (z.B. für Code-Blöcke) muss mit dem `--shell-escape`-Flag kompilliert werden. (Ansonsten wird der Kompatibillitätsmodus geladen)
## Installation
Das Repo muss in den TeX-Path geklont werden.
Diesen findet man mit dem Befehl:
```sh
kpsewhich -var-value=TEXMFHOME
```
> Unter Linux liegt der meist bei `~/texmf/tex/latex`

Beispiel:

```sh
cd path/to/texmf/tex/latex/
git clone https://github.com/FOP-2022/FOPTeX.git
```

oder alternativ kann man den Ordner auch verlinken:

```sh
# Linux/Mac
git clone https://github.com/FOP-2022/FOPTeX.git
ln -s FOPTeX path/to/texmf/tex/latex/FOPTeX 
```
```sh
# Windows
git clone https://github.com/FOP-2022/FOPTeX.git
cd FOPTeX
mklink path/to/texmf/tex/latex/FOPTeX 
```

> Wichtig: bei Dateiänderungen in TeX-Path muss nochmal der Command `texhash` (unter linux mit sudo) ausgeführt werden, bevor die Dateien erkannt werden.