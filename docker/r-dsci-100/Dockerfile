# Copyright (c) UBC-DSCI Development Team.
# Distributed under the terms of the Modified BSD License.
FROM jupyter/r-notebook

USER root

# install vim and libgsl (for tidyclust)
RUN apt-get update && apt-get install -y vim libgsl27

USER ${NB_UID}

WORKDIR "${HOME}/work"

# disable warnings that pollute build logs; seems to be related to the update to python 3.11
# https://discourse.jupyter.org/t/debugger-warning-it-seems-that-frozen-modules-are-being-used-python-3-11-0/16544/12
ENV PYDEVD_DISABLE_FILE_VALIDATION=1

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
    && Rscript -e "install.packages('ISLR', repos='http://cran.us.r-project.org')" \
    && Rscript -e "install.packages('tidyclust', repos='http://cran.us.r-project.org')" \
    && Rscript -e "install.packages('janitor', repos='http://cran.us.r-project.org')"

# Install nbgitpuller, jlab-git
RUN pip install nbgitpuller jupyterlab-git \
  && jupyter lab build  

# Disable the cell toolbar (which ignores metadata and students often accidentally click + delete grading cells)
RUN jupyter labextension disable @jupyterlab/cell-toolbar-extension

# Install the extension to remove the shift+M merge shortcut
COPY shortcuts.jupyterlab-settings /home/${NB_USER}/.jupyter/lab/user-settings/\@jupyterlab/shortcuts-extension/shortcuts.jupyterlab-settings

# Make sure everything in the home folder is owned by NB_USER
USER root
RUN chown -R ${NB_USER} /home/${NB_USER}
USER ${NB_UID}

