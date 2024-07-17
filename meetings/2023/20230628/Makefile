all: $(patsubst %.R,%.out,$(wildcard *.R))
Rmd: meeting_notes_20230628.Rmd
%.out: %.R
	R --no-save < $< &> $@
readme: force
	R --no-save -e 'library(rmarkdown); render("meeting_notes_20230628.Rmd", "pdf_document", encoding="UTF-8")'
clean:
	-rm *~ *png *.out *pdf *~
view:
	-open *.png
force:

