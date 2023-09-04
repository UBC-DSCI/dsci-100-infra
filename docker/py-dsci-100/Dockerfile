# Copyright (c) UBC-DSCI Development Team.
# Distributed under the terms of the Modified BSD License.
FROM jupyter/scipy-notebook

USER root

# install vim
RUN apt-get update && apt-get install -y vim

USER ${NB_UID}

WORKDIR "${HOME}/work"

# disable warnings that pollute build logs; seems to be related to the update to python 3.11
# https://discourse.jupyter.org/t/debugger-warning-it-seems-that-frozen-modules-are-being-used-python-3-11-0/16544/12
ENV PYDEVD_DISABLE_FILE_VALIDATION=1

# update scikit-learn to the current @main (July 20, 2023) 
# to get this merged PR: https://github.com/scikit-learn/scikit-learn/pull/26772
# which fixes this issue: https://github.com/scikit-learn/scikit-learn/issues/26768
RUN pip install --upgrade git+https://github.com/scikit-learn/scikit-learn@7de59b2017f39048880a3858d32c8caef9308954

# Install Python packages
RUN mamba install --quiet --yes \
        'numpy' \
        'jinja2' \
        'click' \
        'ghp-import' \
        'ibis-framework' \
        'nodejs' \
        'psycopg2' \
    && mamba clean --all -f -y \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}" 

# Install some recent python package that might not be on conda yet
RUN pip install pandas"<2.1" altair">=5.0.1" "vegafusion[embed]" vl-convert-python

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

