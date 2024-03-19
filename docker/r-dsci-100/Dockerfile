# Copyright (c) UBC-DSCI Development Team.
# Distributed under the terms of the Modified BSD License.
FROM jupyter/r-notebook:lab-4.0.5

USER root

# install vim and libgsl (for tidyclust)
RUN apt-get update && apt-get install -y vim libgsl27 libgsl-dev build-essential

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
  'jupyter-resource-usage' \
    && mamba clean --all -f -y \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}" \
    && Rscript -e "remotes::install_github('allisonhorst/palmerpenguins@v0.1.0')" \
    && Rscript -e "install.packages('ISLR', repos='http://cran.us.r-project.org')" \
    && Rscript -e "install.packages('scales', repos='http://cran.us.r-project.org')" \
    && Rscript -e "install.packages('tidyclust', repos='http://cran.us.r-project.org')" \
    && Rscript -e "install.packages('janitor', repos='http://cran.us.r-project.org')"

# Install nbgitpuller, jlab-git, newest pexpect 4.9.0
RUN pip install nbgitpuller jupyterlab-git pexpect==4.9.0 \
  && jupyter lab build  

# Disable the cell toolbar (which ignores metadata and students often accidentally click + delete grading cells)
RUN jupyter labextension disable @jupyterlab/cell-toolbar-extension

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