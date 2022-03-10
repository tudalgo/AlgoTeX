# AlgoTeX - Die LaTeX-Vorlage der FOP und AUD

## Voraussetzungen
- Latex-Installation (z.B. MikTex oder TexLive)
- Installation der [TU-Template](https://github.com/tudace/tuda_latex_templates) und der verwendeten Plugins
- Python-Installation mit pip und dem Plugin `pygments`  - wenn pip installiert ist, kann pygments wie folgt installiert werden:
```sh
pip install pygments
```

Um die volle Funktionalität zu erreichen (z.B. für Code-Blöcke) muss mit dem `--shell-escape`-Flag kompilliert werden. (Ansonsten wird der Kompatibillitätsmodus geladen)

Die Vorlage wurde für LuaLaTeX geschrieben, ist aber auch mit PDFLaTeX und XELaTeX
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
git clone https://github.com/TUDalgo/AlgoTeX.git
```

oder alternativ kann man den Ordner auch verlinken:

```sh
# Linux/Mac
git clone https://github.com/TUDalgo/AlgoTeX.git
ln -s AlgoTeX path/to/texmf/tex/latex/AlgoTeX 
```
```batch
REM Windows CMD
git clone https://github.com/TUDalgo/AlgoTeX.git
mklink /J path\to\texmf\tex\latex\AlgoTeX AlgoTeX
```
```pwsh
# Windows PowerShell
git clone https://github.com/TUDalgo/AlgoTeX.git
New-Item -ItemType Junction -Path path\to\texmf\tex\latex\AlgoTeX -Value .\AlgoTeX
```

> Wichtig: bei Dateiänderungen in TeX-Path muss nochmal der Command `texhash` (unter linux mit sudo) ausgeführt werden, bevor die Dateien erkannt werden.  
Unter MiKTeX unter Windows kann man die MiKTeX Console öffnen und dort unter "Tasks" den Befehl "Refresh file name database" wählen.
