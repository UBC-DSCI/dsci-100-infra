# Copyright (c) UBC-DSCI Development Team.
# Distributed under the terms of the Modified BSD License.
FROM ubcdsci/r-dsci-100:latest

LABEL maintainer="Tiffany Timbers <tiffany.timbers@stat.ubc.ca>"

RUN mamba install --quiet --yes "rise"

# install nbgrader and rise extension
RUN mamba install --quiet --yes "nbgrader=0.7.1" \
    && jupyter nbextension install --sys-prefix --py nbgrader --overwrite \
    && jupyter nbextension enable --sys-prefix --py nbgrader \
    && jupyter serverextension enable --sys-prefix --py nbgrader 

RUN mamba clean --all -f -y 

