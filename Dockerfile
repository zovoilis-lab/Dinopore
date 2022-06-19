FROM ubuntu:20.04

COPY ont-guppy-cpu_3.2.4_linux64.tar.gz /guppy/

COPY code /code/

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y libidn11 libgssapi-krb5-2 wget

WORKDIR /

RUN tar -xf /guppy/ont-guppy-cpu_3.2.4_linux64.tar.gz && \
    ln -s /ont-guppy-cpu/bin/guppy_* /usr/bin/

# Install miniconda
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh \
     && /bin/bash ~/miniconda.sh -b -p /opt/conda

# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH

RUN conda create -c bioconda -n myenv python=3.8.5 h5py nanopolish pillow pyyaml requests samtools scipy



