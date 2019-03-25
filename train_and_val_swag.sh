#!/usr/bin/env bash
export PYTHONPATH=$(pwd)
python bert/run_bert.py \
  --output_dir=gs://tpututorial/swag1/ \
  --input_data=data/swag1.jsonl \
  --do_lower_case=True \
  --max_seq_length=64 \
  --do_train=True \
  --predict_val=True \
  --predict_test=False \
  --train_batch_size=16 \
  --predict_batch_size=256 \
  --learning_rate=2e-5 \
  --num_train_epochs=3 \
  --warmup_proportion=0.1 \
  --iterations_per_loop=1000 \
  --use_tpu=True \
  --tpu_name=$(hostname) \
  --bert_large=True