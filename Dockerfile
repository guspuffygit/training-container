FROM thebloke/cuda11.8.0-ubuntu22.04-oneclick:latest

COPY . .

ENTRYPOINT ["/bin/bash", "-c", "/workspace/entrypoint.sh"]

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git \
    curl \
    jq \
    nano \
    pip install -r requirements.txt

RUN git clone https://github.com/OpenAccess-AI-Collective/axolotl.git && \
  cd axolotl && \
  pip install -r requirements.txt && \
  pip install -e '.[flash-attn,deepspeed]' && \
  pip install -U git+https://github.com/huggingface/peft.git
