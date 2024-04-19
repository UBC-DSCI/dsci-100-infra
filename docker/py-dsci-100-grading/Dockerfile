# Copyright (c) UBC-DSCI Development Team.
# Distributed under the terms of the Modified BSD License.
FROM ubcdsci/py-dsci-100:latest

# install nbgrader and the rise slides extension
RUN pip install jupyterlab-rise nbgrader

# Allow all shortcuts
RUN rm -f /home/${NB_USER}/.jupyter/lab/user-settings/\@jupyterlab/shortcuts-extension/shortcuts.jupyterlab-settings

# Clean the cache
RUN mamba clean --all -f -y 

