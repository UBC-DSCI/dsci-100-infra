# Copyright (c) UBC-DSCI Development Team.
# Distributed under the terms of the Modified BSD License.
FROM ubcdsci/r-dsci-100:latest

# install nbgrader and the rise slides extension
# RUN pip install jupyterlab-rise nbgrader
RUN pip install nbgrader

# install rise from fork wheel with fixed CSS
COPY jupyterlab_rise-0.42.0-py3-none-any.whl ./
RUN pip install wheel && pip install jupyterlab_rise-0.42.0-py3-none-any.whl && rm -f jupyterlab_rise-0.42.0-py3-none-any.whl

# Allow all shortcuts
RUN rm -f /home/${NB_USER}/.jupyter/lab/user-settings/\@jupyterlab/shortcuts-extension/shortcuts.jupyterlab-settings

# Clean the cache
RUN mamba clean --all -f -y 

