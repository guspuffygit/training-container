huggingface-cli login --token $HUGGING_FACE_HUB_TOKEN

wandb login $WANDB_TOKEN

git clone https://github.com/guspuffygit/training.git

git clone https://github.com/OpenAccess-AI-Collective/axolotl.git
pip install -r axolotl/requirements.txt

python axolotl/scripts/finetune.py training/train.yaml
