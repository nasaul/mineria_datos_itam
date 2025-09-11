CONDA_ENV = mineria_datos
SHELL := /bin/bash

preview:
	source $$(conda info --base)/etc/profile.d/conda.sh && \
	conda activate $(CONDA_ENV) && \
	quarto preview chapters

render: 
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
	rm -rf docs/

help:
	@echo "Available targets:"
	@echo "  preview     - Start Quarto preview server with conda environment"
	@echo "  render      - Render the book to HTML with conda environment"
	@echo "  install-env - Create and setup the conda environment"
	@echo "  clean       - Remove generated files and cache"
	@echo "  help        - Show this help message"

.PHONY: preview render install-env clean help