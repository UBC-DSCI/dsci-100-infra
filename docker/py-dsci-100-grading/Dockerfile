# Copyright (c) UBC-DSCI Development Team.
# Distributed under the terms of the Modified BSD License.
FROM ubcdsci/py-dsci-100:latest

# install the rise slides extension
RUN pip install jupyterlab-rise 

# install nbgrader
RUN pip install "git+https://github.com/jupyter/nbgrader.git"

# Clean the cache
RUN mamba clean --all -f -y 

