# A good simple tutorial about Make can be found at http://kbroman.org/minimal_make/ 
R_OPTS=--no-save --no-restore --no-init-file --no-site-file

ms/ms.pdf: ms/ms.Rmd ms/paper-template.bib figures/m100-progression.pdf
	Rscript -e 'rmarkdown::render("ms/ms.Rmd", output_format = "bookdown::pdf_document2", output_file = "ms.pdf")'

figures/m100-progression.pdf: r/01_process-data.R r/02_plot-progression.R
	R CMD BATCH r/01_process-data.R
	R CMD BATCH r/02_plot-progression.R
	
clean: 
	\rm -f *~ *.Rout */*~ */*.Rout .RData Rplots.pdf
