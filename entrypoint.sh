huggingface-cli login --token $HUGGING_FACE_HUB_TOKEN

wandb login $WANDB_TOKEN

git clone https://github.com/guspuffygit/training.git

python axolotl/scripts/finetune.py training/train.yaml
