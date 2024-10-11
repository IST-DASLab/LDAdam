export SEED=1234
export MODEL=llama_350m
export LEARNING_RATE=1e-3

python -m torch.distributed.run --standalone --nproc_per_node=1 experiments/c4_pretraining/run_llama_pretraining.py \
    --model_config experiments/c4_pretraining/configs/$MODEL.json \
    --max_length 256 \
    --dtype bfloat16 \
    --num_training_steps 55000 \
    --warmup_steps 5500 \
    --eval_every 1500 \
    --save_every 10000 \
    --total_batch_size 512 \
    --batch_size 128 \
    --gradient_accumulation 4 \
    --save_dir experiments/c4_pretraining/results/Adam/$MODEL/lr_$LEARNING_RATE \
    --seed $SEED \
    \
    --optimizer adamw \
    --lr $LEARNING_RATE \
    --beta1 0.9 \
    --beta2 0.999 \
    --eps 1e-8 \
    --weight_decay 0.0 \
    \
    --grad_clipping 1.0 \
    \
    --wandb_project LDAdam_C4_${MODEL} \
    --wandb_run_name Adam_$SEED \