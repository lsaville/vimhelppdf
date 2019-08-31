define TASKS
letter  make letter-sized version
update  update vim help and vim-faq from repository
clean   delete intermediate files
clobber delete all files
endef
export TASKS

SHELL=/bin/bash

docdir = doc
helpfiles = $(wildcard $(docdir)/*.txt)

letter: vimhelp.pdf

update:
	./update.sh

$(docdir):
	./update.sh

%.pdf: %.tex body.tex FORCE
	xelatex $<

#body.tex: $(helpfiles) $(docdir) contents.txt
#	python h2h.py

body.tex: $(helpfiles) $(docdir) user-manual.txt
	python h2h.py

clean:
	-rm body.tex *.log *.aux *.toc *.out
	-rm -r $(docdir)

clobber: clean
	-rm vimhelp{,-ipad,-a4}.pdf

help:
	@echo "$$TASKS"

.PHONY: letter update help clean clobber FORCE
