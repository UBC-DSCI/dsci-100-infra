# Copyright (c) UBC-DSCI Development Team.
# Distributed under the terms of the Modified BSD License.
FROM ubcdsci/r-dsci-100:latest

# install nbgrader and the rise slides extension
RUN pip install jupyterlab-rise nbgrader

# Clean the cache
RUN mamba clean --all -f -y 

