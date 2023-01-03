# Copyright (c) UBC-DSCI Development Team.
# Distributed under the terms of the Modified BSD License.
FROM ubcdsci/py-dsci-100:latest

# install the rise slides extension
RUN mamba install --quiet --yes "rise"

# install nbgrader
RUN pip3 install --user git+https://github.com/ubc-dsci/nbgrader@autotest-with-limit-cell-height-ext \
    && jupyter nbextension install --sys-prefix --py nbgrader --overwrite \
    && jupyter nbextension enable --sys-prefix --py nbgrader \
    && jupyter serverextension enable --sys-prefix --py nbgrader 

# Clean the cache
RUN mamba clean --all -f -y 

