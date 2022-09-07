# AlgoTeX - Die LaTeX-Vorlage der FOP und AUD
[![Build](https://github.com/tudalgo/AlgoTeX/actions/workflows/build.yml/badge.svg)](https://github.com/tudalgo/AlgoTeX/actions/workflows/build.yml)
## Voraussetzungen
- Latex-Installation (z.B. MikTex oder TexLive)
- Installation der [TU-Template](https://github.com/tudace/tuda_latex_templates) und der verwendeten Plugins
- Python-Installation mit pip und dem Plugin `pygments`  - wenn pip installiert ist, kann pygments wie folgt installiert werden:
```sh
pip install pygments
```

Um die volle Funktionalität zu erreichen (z.B. für Code-Blöcke) muss mit dem `--shell-escape`-Flag kompilliert werden. (Ansonsten wird der Kompatibillitätsmodus geladen). Bei VS-Code mit LaTeX-Workshop kann dazu beispielsweise die `settings.json` angepasst werden, indem man Folgendes anhängt:
```jsonc
"latex-workshop.latex.tools": [
        {
            "name": "latexmk",
            "command": "latexmk",
            "args": [
                "--shell-escape",
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "-lualatex", // alternativ: "-pdf" o.ä.
                "-outdir=%OUTDIR%",
                "%DOC%"
            ]
        },
    ],
```
Dadurch kann die Vorlage Reibungslos mit VS-Code kompillieren.


Die Vorlage wurde für LuaLaTeX geschrieben, ist aber dank des Latex3-Kernels auch mit PDFLaTeX und XELaTeX kompatibel.
## Installation

### Automatisch
Für Arch-basierende Linux-Distributionen wird das Paket [`algotex-git`](https://aur.archlinux.org/packages/algotex-git) im [`AUR`](https://aur.archlinux.org/) bereitgestellt.

### Manuell
#### l3build
Da es aktuell noch keine Vollständige Dokumentation gibt, ist das Paket nicht auf CTAN erhältlich. Das Paket kann durch den folgenden Befehl installiert werden:
```sh
l3build install --full
```
Alternativ ohne Dokumentation auch durch:
```sh
l3build install
```

#### komplett manuell
Falls `l3build` nicht verfügbar ist (z.B. bei Overleaf oder Sharelatex) kann der Inhalt des [`tex`](tex/)-Ordners der Vorlage in das Arbeitsverzeichnis kopiert werden, oder per .latexmkrc eingebunden werden.

Den lokalen TeX-Path findet man mit dem Befehl:
```sh
kpsewhich -var-value=TEXMFHOME
```
> Unter Linux liegt der meist bei `~/texmf/tex/latex`

Dazu kann man den [`tex`](tex/)-Ordner verlinken:

```sh
# Linux/Mac
git clone https://github.com/TUDalgo/AlgoTeX.git
cd AlgoTeX
mkdir -p "$(kpsewhich -var-value=TEXMFHOME)/tex/latex/AlgoTeX"
# Ordner Verlinkrn
ln -s "$(pwd)/tex" "$(kpsewhich -var-value=TEXMFHOME)/tex/latex/AlgoTeX"
sudo texhash "$(kpsewhich -var-value=TEXMFHOME)"
```
```bat
REM Windows - Batch
git clone https://github.com/TUDalgo/AlgoTeX.git
cd AlgoTeX/tex
REM (hierbei `path/to/texmf/` mit dem entsprechenden Tex-Path ersetzen)
mklink /J path/to/texmf/tex/latex/AlgoTeX 
texhash
```
```pwsh
# Windows - PowerShell
git clone https://github.com/TUDalgo/AlgoTeX.git
New-Item -ItemType Junction -Path path\to\texmf\tex\latex\AlgoTeX -Value .\AlgoTeX\tex
```

> Wichtig: bei Dateiänderungen in TeX-Path muss nochmal der Command `texhash` (unter linux mit sudo) ausgeführt werden, bevor die Dateien erkannt werden.  
Unter MiKTeX unter Windows kann man die MiKTeX Console öffnen und dort unter "Tasks" den Befehl "Refresh file name database" wählen.

## Verwendung
Eine Anleitung der `algoexercise` findet sich im Ordner `doc`. Anleitung zu den anderen Klassen und Paketen werden in den nächsten Wochen folgen (kein ETA).

## Was ist geplant?
- Dokumentation
- Style-Guide
- Erweiterung der Vorlage auf `TudaPub` und `TudaPoster`
## Wie kann ich Helfen?
Wenn dir ein Fehler aufgefallen ist, du die Vorlage erweitern willst oder einfach nur Anregungen hast kannst du entwerder einen PR oder Issue eröffnen, oder mir auf Discord an `Rubosplay#0815` eine DM senden.
