# Copyright (c) UBC-DSCI Development Team.
# Distributed under the terms of the Modified BSD License.
FROM jupyter/r-notebook

LABEL maintainer="Tiffany Timbers <tiffany.timbers@gmail.com>"

USER root

# install vim
RUN apt-get update && apt-get install -y vim

USER ${NB_UID}

WORKDIR "${HOME}"

# Install R packages
RUN mamba install --quiet --yes \
    'r-cowplot' \
    'r-ggally' \
	'r-gridextra' \
	'r-infer' \
	'r-kknn' \
	'r-testthat' \
	'r-rpostgres' \
    && mamba clean --all -f -y \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}" \
    && Rscript -e "remotes::install_github('allisonhorst/palmerpenguins@v0.1.0')" \
    && Rscript -e "install.packages('ISLR', repos='http://cran.us.r-project.org')"

# Install nbgitpuller, jupytext, jlab-git
RUN pip install git+https://github.com/data-8/nbgitpuller@c23461d4f7ce47ec4e0d2bcfc3b2fde4939b80f8 \
  && jupyter serverextension enable --sys-prefix nbgitpuller \
  && pip install jupyterlab-git \
  && pip install jupytext --upgrade \
  && jupyter labextension install @techrah/text-shortcuts \
  && jupyter lab build  

COPY rm-merge-shortcut.py /tmp/user-settings/\@jupyterlab/shortcuts-extension/shortcuts.jupyterlab-settings
