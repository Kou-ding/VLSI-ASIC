TEX_MAIN = vlsi.tex

all: vlsi

vlsi: $(TEX_MAIN)
	xelatex -pdf $(TEX_MAIN)

clean:
	latexmk -c $(TEX_MAIN)
	rm -f *.bbl 