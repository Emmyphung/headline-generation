#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=5
#SBATCH --time=15:00:00
#SBATCH --mem-per-cpu=10GB
#SBATCH --job-name=mnli-small-title
#SBATCH --mail-type=END
#SBATCH --mail-user=mtp363@nyu.edu
#SBATCH --output=delete_error_train_eval_bert_mnli_small_title_20ep_%j.out
#SBATCH --gres=gpu:1
  
# Refer to https://sites.google.com/a/nyu.edu/nyu-hpc/documentation/prince/batch/submitting-jobs-with-sbatch
# for more information about the above options

# Remove all unused system modules
module purge

# Activate the conda environment
module load anaconda3
source activate env_nlp_conda

BERT_CKPT=/misc/vlgscratch5/PichenyGroup/s2i-common/headline-generation/models/official/nlp/nhnet/bert_mnli_checkpoint
DATA_FOLDER=/misc/vlgscratch5/PichenyGroup/s2i-common/headline-generation/models/official/nlp/nhnet/processed_small_title_label
MODEL_DIR=/misc/vlgscratch5/PichenyGroup/s2i-common/headline-generation/models/official/nlp/nhnet/model_out_bert_mnli_small_title

# Execute the script

# Training for 5 more epochs and eval

python trainer.py \
--mode=train_and_eval \
--init_checkpoint=$BERT_CKPT/variables/variables \
--params_override='init_from_bert2bert=false' \
--train_file_pattern=$DATA_FOLDER/train* \
--eval_file_pattern=$DATA_FOLDER/test* \
--model_dir=$MODEL_DIR \
--len_title=15 \
--len_passage=200 \
--num_nhnet_articles=1 \
--model_type=nhnet \
--train_batch_size=16 \
--train_steps=500 \
--steps_per_loop=1 \
--checkpoint_interval=100 \
--distribution_strategy=mirrored \
--vocab=$BERT_CKPT/assets/vocab.txt \
--do_lower_case=True \

# And we're done!
