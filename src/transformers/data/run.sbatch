#SBATCH --gres=gpu:1
#SBATCH --mem=16000
#SBATCH --time=0:30:00
#SBATCH --job-name="nlu_hw4"

module purge
module load anaconda3/5.3.1
module load cuda/10.0.130
module load gcc/6.3.0

# Replace with your NetID
NETID=abc123
source activate /scratch/${ddb345}/nlu/env

cd /scratch/${ddb345}/nlu/code/transformers
export PYTHONPATH=/scratch/${ddb345}/nlu/code/transformers/src:$PYTHONPATH
python ./examples/run_glue.py \
    --model_type bert \
    --model_name_or_path bert-base-uncased \
    --task_name ${TASK_NAME} \
    --do_train \
    --do_eval \
    --data_dir ${GLUE_DIR}/${TASK_NAME} \
    --max_seq_length 128 \
    --per_gpu_eval_batch_size=8   \
    --per_gpu_train_batch_size=8   \
    --learning_rate 2e-5 \
    --num_train_epochs 3.0 \
    --output_dir /scratch/${ddb345}/nlu/${TASK_NAME}_run/
