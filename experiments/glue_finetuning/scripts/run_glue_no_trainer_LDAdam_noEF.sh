export SEED=123
export TASK_NAME=mnli
export LEARNING_RATE=1e-5

python -m experiments.glue_finetuning.run_glue_no_trainer_HF \
  --model_name_or_path roberta-base \
  --task_name $TASK_NAME \
  --max_length 128 \
  --per_device_train_batch_size 16 \
  --num_train_epochs 3 \
  --output_dir experiments/glue_finetuning/results/LDAdam_noEF/$TASK_NAME/$LEARNING_RATE/$SEED \
  --seed $SEED \
  \
  --optimizer ldadamw \
  --learning_rate $LEARNING_RATE \
  --beta1 0.908 \
  --beta2 0.99 \
  --eps 1e-8 \
  --weight_decay 0.00 \
  \
  --rho 0.908 \
  --rank 8 \
  \
  --with_tracking \
  --report_to wandb \
  --wandb_project LDAdam_GLUE_RoBERTa-base \
  --wandb_run_name LDAdam_noEF_${TASK_NAME}_${LEARNING_RATE}_${SEED} \
  \
  --no_error_feedback