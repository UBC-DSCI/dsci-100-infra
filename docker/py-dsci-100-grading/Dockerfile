# Copyright (c) UBC-DSCI Development Team.
# Distributed under the terms of the Modified BSD License.
FROM ubcdsci/py-dsci-100:latest

# install the rise slides extension
RUN mamba install --quiet --yes "rise"

# install a particular version of nodejs required by nbgrader
RUN mamba install --quiet --yes nodejs=16.17.1

# install nbgrader (autotest-with-limit-cell-height-ext)
RUN  git clone -b autotest-with-limit-cell-height-ext https://github.com/UBC-DSCI/nbgrader \ 
    && cd nbgrader \ 
    && pip install . \
    && jupyter nbextension install --sys-prefix --py nbgrader --overwrite \
    && jupyter nbextension enable --sys-prefix --py nbgrader \
    && jupyter serverextension enable --sys-prefix --py nbgrader 

# Clean the cache
RUN mamba clean --all -f -y 

# re-upgrade jupyter-server (mamba downgrades it)
RUN pip install --upgrade jupyter-server

