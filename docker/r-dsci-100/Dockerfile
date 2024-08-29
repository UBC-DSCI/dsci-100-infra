# Copyright (c) UBC-DSCI Development Team.
# Distributed under the terms of the Modified BSD License.
FROM quay.io/jupyter/r-notebook

USER root

# install vim and libgsl (for tidyclust)
RUN apt-get update && apt-get install -y vim libgsl-dev build-essential

USER ${NB_UID}

WORKDIR "${HOME}/work"

# disable warnings that pollute build logs; seems to be related to the update to python 3.11
# https://discourse.jupyter.org/t/debugger-warning-it-seems-that-frozen-modules-are-being-used-python-3-11-0/16544/12
ENV PYDEVD_DISABLE_FILE_VALIDATION=1

# Install mamba packages
RUN mamba install --quiet --yes \
  'r-cowplot' \
  'r-ggally' \
  'r-gridextra' \
  'r-infer' \
  'r-kknn' \
  'r-testthat' \
  'r-rpostgres' \
  'r-themis' \
  'jupyter-resource-usage' \
  && mamba clean --all -f -y \
  && fix-permissions "${CONDA_DIR}" \
  && fix-permissions "/home/${NB_USER}"

# Install CRAN packages
RUN Rscript -e "lib <- 'palmerpenguins'; remotes::install_github('allisonhorst/palmerpenguins@v0.1.0'); if ( ! library('palmerpenguins',character.only=TRUE,logical.return=TRUE)){quit(status=1,save='no')}" \
  && Rscript -e "lib <- 'ISLR'; install.packages(lib, repos='http://cran.us.r-project.org'); if ( ! library(lib,character.only=TRUE,logical.return=TRUE)){quit(status=1,save='no')}" \
  && Rscript -e "lib <- 'scales'; install.packages(lib, repos='http://cran.us.r-project.org'); if ( ! library(lib,character.only=TRUE,logical.return=TRUE)){quit(status=1,save='no')}" \
  && Rscript -e "lib <- 'janitor'; install.packages(lib, repos='http://cran.us.r-project.org'); if ( ! library(lib,character.only=TRUE,logical.return=TRUE)){quit(status=1,save='no')}" 

# Install archived CRAN packages to fix tune_cluster issue with apparent
RUN Rscript -e "options(repos=c(CRAN='https://packagemanager.rstudio.com/cran/2024-03-21')); require(devtools); install_version('Rfast', repos = 'https://packagemanager.rstudio.com/cran/2024-03-21')" \
  && Rscript -e "options(repos=c(CRAN='https://packagemanager.rstudio.com/cran/2024-03-21')); require(devtools); install_version('tidyclust', version = '0.2.1', repos = 'https://packagemanager.rstudio.com/cran/2024-03-21'); if ( ! library('tidyclust',character.only=TRUE,logical.return=TRUE)){quit(status=1,save='no')}" \
  && Rscript -e "options(repos=c(CRAN='https://packagemanager.rstudio.com/cran/2024-03-21')); require(devtools); install_version('tidymodels', version = '1.1.1', repos = 'https://packagemanager.rstudio.com/cran/2024-03-21')" \
  && Rscript -e "options(repos=c(CRAN='https://packagemanager.rstudio.com/cran/2024-03-21')); require(devtools); install_version('workflowsets', version = '1.0.1', repos = 'https://packagemanager.rstudio.com/cran/2024-03-21')" \
  && Rscript -e "options(repos=c(CRAN='https://packagemanager.rstudio.com/cran/2024-03-21')); require(devtools); install_version('tune', version = '1.1.2', repos = 'https://packagemanager.rstudio.com/cran/2024-03-21')" \
  && Rscript -e "lib <- 'withr'; install.packages('https://cran.r-project.org/src/contrib/Archive/withr/withr_2.5.0.tar.gz', repos=NULL, type='source'); if ( ! library(lib,character.only=TRUE,logical.return=TRUE)){quit(status=1,save='no')}"

# Install nbgitpuller, jlab-git, newest pexpect 4.9.0
RUN pip install nbgitpuller jupyterlab-git pexpect==4.9.0

# Disable the cell toolbar (which ignores metadata and students often accidentally click + delete grading cells)
RUN jupyter labextension disable @jupyterlab/cell-toolbar-extension

# Disable announcement pop-up on start
RUN jupyter labextension disable "@jupyterlab/apputils-extension:announcements"

# Install the extension to remove the shift+M merge shortcut
COPY shortcuts.jupyterlab-settings /home/${NB_USER}/.jupyter/lab/user-settings/\@jupyterlab/shortcuts-extension/shortcuts.jupyterlab-settings

# Copy jupyter_server_config.py which allows students to see and delete hidden files
COPY jupyter_server_config.py /home/${NB_USER}/.jupyter

# Copy gitconfig that sets global default pull strategy to merge
COPY .gitconfig /home/${NB_USER}/

# Make sure everything in the home folder is owned by NB_USER
USER root
RUN chown -R ${NB_USER} /home/${NB_USER}
USER ${NB_UID}

# Disable healthcheck for performance reasons
HEALTHCHECK NONE
