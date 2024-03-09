FROM nvidia/cuda:12.3.2-runtime-ubuntu22.04

ENV HOME=/root
ENV PROFILE_PATH=${HOME}/.bashrc
ENV DEBIAN_FRONTEND noninteractive
ENV PYENV_ROOT=${HOME}/.pyenv
ENV PATH=${PYENV_ROOT}/bin:${PATH}
ENV PYTHON_VERSION=3.12

RUN apt-get clean && \
    apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install --no-install-recommends -y \
    apt-utils \
    ca-certificates \
    curl \
    g++ \
    git \
    jq \
    libbz2-dev \
    libffi-dev \
    libgl1-mesa-glx \
    liblzma-dev \
    libncurses5-dev \
    libpq-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libusb-1.0-0 \
    libxerces-c-dev \
    libxml2-dev \
    libxmlsec1-dev \
    locales \
    protobuf-compiler \
    tk-dev \
    unzip \
    wget \
    xz-utils \
    zlib1g-dev && \
    locale-gen en_US.UTF-8
# https://github.com/pyenv/pyenv/wiki#suggested-build-environment

RUN git clone https://github.com/pyenv/pyenv.git ${PYENV_ROOT}

# RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ${PROFILE_PATH}
# RUN echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ${PROFILE_PATH}
# RUN echo 'eval "$(pyenv init -)"' >> ${PROFILE_PATH}

ENV PATH=${PYENV_ROOT}/bin:${PATH}
ENV PATH=${PYENV_ROOT}/shims:${PATH}
RUN eval "$(pyenv init -)"

RUN pyenv install --skip-existing ${PYTHON_VERSION}
RUN pyenv global ${PYTHON_VERSION}

WORKDIR /user/dev
ADD ./requirements.txt /user/dev/
RUN python -m pip install -r requirements.txt
