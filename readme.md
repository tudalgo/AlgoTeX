# FOPTeX - Die LaTeX-Vorlage der FOP und AUD

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