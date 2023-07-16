# Copyright (c) UBC-DSCI Development Team.
# Distributed under the terms of the Modified BSD License.
FROM ubcdsci/r-dsci-100

# install the rise slides extension
RUN mamba install --quiet --yes "rise"

# install nbgrader
RUN mamba install --quiet --yes nbgrader \
    && jupyter nbextension install --sys-prefix --py nbgrader --overwrite \
    && jupyter nbextension enable --sys-prefix --py nbgrader \
    && jupyter serverextension enable --sys-prefix --py nbgrader 

# Clean the cache
RUN mamba clean --all -f -y 

# re-upgrade jupyter-server (mamba downgrades it)
RUN pip install --upgrade jupyter-server

