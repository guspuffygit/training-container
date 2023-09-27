FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04 as builder

RUN apt update \
      && apt install -y \
        build-essential \
        zlib1g-dev \
        libncurses5-dev \
        libgdbm-dev \
        libnss3-dev \
        libssl-dev \
        libsqlite3-dev \
        libreadline-dev \
        libffi-dev \
        wget \
        libbz2-dev \
      && wget -q https://www.python.org/ftp/python/3.10.13/Python-3.10.13.tgz \
      && tar -xf Python-3.10.13.tgz \
      && cd Python-3.10.13 \
      && ./configure \
      && make -j$(nproc)

RUN cd Python-3.10.13 && make install \
      && python3.10 --version

FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

COPY --from=builder /usr/local/bin /usr/local/bin
COPY --from=builder /usr/local/lib /usr/local/lib

RUN ln -s $(which python3.10) /usr/local/bin/python
RUN ln -s $(which pip3) /usr/local/bin/pip

WORKDIR /workspace

COPY . .

ENTRYPOINT ["/bin/bash", "-c", "/workspace/entrypoint.sh"]

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git \
    curl \
    jq \
    nano && \
    pip install -r requirements.txt
