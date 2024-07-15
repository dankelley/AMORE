all: $(patsubst %.Rmd,%.pdf,$(wildcard *.Rmd))
%.pdf: %.Rmd
	R --no-save -e 'library(rmarkdown); render("'$<'", "pdf_document", encoding="UTF-8")'
clean:
	-rm *~ *png *.out *pdf

