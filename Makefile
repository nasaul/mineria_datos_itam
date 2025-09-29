CONDA_ENV = mineria_datos
SHELL := /bin/bash

preview: setup-links
	source $$(conda info --base)/etc/profile.d/conda.sh && \
	conda activate $(CONDA_ENV) && \
	quarto preview chapters

setup-links:
	@if [ ! -L "chapters/introduccion.ipynb" ]; then \
		cd chapters && \
		ln -sf ../notebooks/*.ipynb . && \
		echo "Created symbolic links to notebooks"; \
	fi

render: setup-links
	source $$(conda info --base)/etc/profile.d/conda.sh && \
	conda activate $(CONDA_ENV) && \
	quarto render chapters

install-env:
	conda env list | grep -q $(CONDA_ENV) || conda create -n $(CONDA_ENV) python=3.10 -y
	source $$(conda info --base)/etc/profile.d/conda.sh && \
	conda activate $(CONDA_ENV) && \
	mamba install jupyter numpy pandas matplotlib seaborn scikit-learn nbclient ipykernel pyyaml -y

clean:
	rm -rf chapters/_freeze/
	rm -rf chapters/.quarto/
	rm -rf docs/
	rm -f chapters/*.ipynb
	rm -f notebooks/*.html

help:
	@echo "Available targets:"
	@echo "  preview     - Start Quarto preview server with conda environment"
	@echo "  render      - Render the book to HTML with conda environment"
	@echo "  setup-links - Create symbolic links to notebooks (auto-run by preview/render)"
	@echo "  install-env - Create and setup the conda environment"
	@echo "  clean       - Remove generated files and cache"
	@echo "  help        - Show this help message"

.PHONY: preview render setup-links install-env clean help