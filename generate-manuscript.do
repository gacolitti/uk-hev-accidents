
// Change working directory
cd "/Users/Gio/Documents/stata/uk-hev-accidents/"

markstat using manuscript, pdf strict keep(do tex) bib 

whereis pdflatex
! "`r(pdflatex)'" manuscript.tex
view browse manuscript.pdf


