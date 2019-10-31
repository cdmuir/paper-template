# paper-template

This repository is a template a reproducible paper. It's based somewhat on https://github.com/daijiang/workflow_demo, but I've borrowed and modified ideas from lots of places.

This repository has the following file folders:

- `figures`: figures generated from R code.
- `ms`: manuscript input (e.g. `ms.Rmd` and `paper-template.bib`) and output (e.g. `ms.pdf`)files
- `objects`: objects (usually `.rds` files) generated from scripts
- `processed-data`: raw data that has been processed by scripts - this should be overwritable
- `r`: R scripts - Stan scripts go in `stan`; python scripts go in `python`, etc.
- `raw-data`: raw data - this should **not** be overwritable
- `template`: manuscript style files

Some prerequires (copied from https://github.com/daijiang/workflow_demo):

- `GNU Make`: to document file dependencies and automate workflow. In terminal, you can just type `make` to render the rmarkdown file to pdf and html.
- `R`: for data clean and analyses.
- `LaTeX`: for fine control of typesetting and pdf generation.
- `Pandoc`: for file types converting, e.g. convert markdown file to pdf or docx files or html files.
	+ if you have `Rstudio` installed, you can also use pandoc shipped with Rstudio:   

			sudo ln -s /usr/lib/rstudio/bin/pandoc/pandoc /usr/local/bin   
			sudo ln -s /usr/lib/rstudio/bin/pandoc/pandoc-citeproc /usr/local/bin

## Contributing

Contributions to this demo are more than welcome. Just fork and make changes, then file a pull request. Thanks!
