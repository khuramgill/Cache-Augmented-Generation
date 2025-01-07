#!/bin/bash
logfilename="./log/random-squad-k3.log"
# while log file exists, create a new one called random_i.log
i=1
while [ -f $logfilename ]; do
    echo "log file ${logfilename} exists, create a new one"
    logfilename="./log/random-squad$i-k3_$i.log"
    i=$(($i+1))
done

# datasets=("squad-train")
# when k = 3, tokens = 21,000
# when k = 4, tokens = 32,000
# when k = 7, tokens = 50,000

# 在這裡自訂 k 和 p 的值
k=3  # 設定 k 值
p=100  # 設定 p 值

datasets=("squad-train")
# models=("3.1-8B" "3.2-3B" "3.2-1B")
models=("3.1-8B")
indices=("openai" "bm25")
maxQuestions=("500")
top_k=("1" "3" "5" "10" "20")

for dataset in "${datasets[@]}"; do
  for model in "${models[@]}"; do
    for maxQuestion in "${maxQuestions[@]}"; do
      
      randomSeed=$(shuf -i 1-100000 -n 1)
      echo "Random seed: $randomSeed" >> $logfilename

      # Run KVCACHE without cache
      echo "Running KVCACHE for $dataset, maxKnowledge $k, maxParagraph $p, maxQuestion $maxQuestion, model $model"
      echo "Running KVCACHE for $dataset, maxKnowledge $k, maxParagraph $p, maxQuestion $maxQuestion, model $model" >> $logfilename
      python ./kvcache.py --kvcache file --dataset "$dataset" --similarity bertscore \
        --maxKnowledge "$k" --maxParagraph "$p" --maxQuestion "$maxQuestion" --usePrompt \
        --modelname "meta-llama/Llama-${model}-Instruct" --randomSeed  "$randomSeed" \
        --output "./random_results/${dataset}/k${k}/result_${model}_k${k}_p${p}_q${maxQuestion}_${dataset}_bertscore_kvcache_nokv.txt_${i}"
      
      # Run KVCACHE
      echo "Running KVCACHE for $dataset, maxKnowledge $k, maxParagraph $p, maxQuestion $maxQuestion, model $model"
      echo "Running KVCACHE for $dataset, maxKnowledge $k, maxParagraph $p, maxQuestion $maxQuestion, model $model" >> $logfilename
      python ./kvcache.py --kvcache file --dataset "$dataset" --similarity bertscore \
        --maxKnowledge "$k" --maxParagraph "$p" --maxQuestion "$maxQuestion" \
        --modelname "meta-llama/Llama-${model}-Instruct" --randomSeed  "$randomSeed" \
        --output "./random_results/${dataset}/k${k}/result_${model}_k${k}_p${p}_q${maxQuestion}_${dataset}_bertscore_kvcache.txt_${i}"
      
      # Run RAG
      for topk in "${top_k[@]}"; do
          for index in "${indices[@]}"; do
            echo "Running RAG with $index for $dataset, maxKnowledge $k, maxParagraph $p, maxQuestion $maxQuestion, model $model, topk ${topk}"
            echo "Running RAG with $index for $dataset, maxKnowledge $k, maxParagraph $p, maxQuestion $maxQuestion, model $model, topk ${topk}" >> $logfilename
            python ./rag.py --index "$index" --dataset "$dataset" --similarity bertscore \
              --maxKnowledge "$k" --maxParagraph "$p" --maxQuestion "$maxQuestion" --topk "$topk" \
              --modelname "meta-llama/Llama-${model}-Instruct" --randomSeed  "$randomSeed" \
              --output "./random_results/${dataset}/k${k}/result_${model}_k${k}_p${p}_q${maxQuestion}_${dataset}_bertscore_rag_Index_${index}_top${topk}.txt_${i}" 
          done
      done
      
    done
  done
done

logfilename="./log/random-squad-k3.log"
# while log file exists, create a new one called random_i.log
i=1
while [ -f $logfilename ]; do
    echo "log file ${logfilename} exists, create a new one"
    logfilename="./log/random-squad$i-k3_$i.log"
    i=$(($i+1))
done

# datasets=("squad-train")
# when k = 3, tokens = 21,000
# when k = 4, tokens = 32,000
# when k = 7, tokens = 50,000

# 在這裡自訂 k 和 p 的值
k=5  # 設定 k 值
p=100  # 設定 p 值

datasets=("squad-train")
# models=("3.1-8B" "3.2-3B" "3.2-1B")
models=("3.1-8B")
indices=("openai" "bm25")
maxQuestions=("500")
top_k=("1" "3" "5" "10" "20")

for dataset in "${datasets[@]}"; do
  for model in "${models[@]}"; do
    for maxQuestion in "${maxQuestions[@]}"; do
      
      randomSeed=$(shuf -i 1-100000 -n 1)
      echo "Random seed: $randomSeed" >> $logfilename

      # Run KVCACHE without cache
      echo "Running KVCACHE for $dataset, maxKnowledge $k, maxParagraph $p, maxQuestion $maxQuestion, model $model"
      echo "Running KVCACHE for $dataset, maxKnowledge $k, maxParagraph $p, maxQuestion $maxQuestion, model $model" >> $logfilename
      python ./kvcache.py --kvcache file --dataset "$dataset" --similarity bertscore \
        --maxKnowledge "$k" --maxParagraph "$p" --maxQuestion "$maxQuestion" --usePrompt \
        --modelname "meta-llama/Llama-${model}-Instruct" --randomSeed  "$randomSeed" \
        --output "./random_results/${dataset}/k${k}/result_${model}_k${k}_p${p}_q${maxQuestion}_${dataset}_bertscore_kvcache_nokv.txt_${i}"
      
      # Run KVCACHE
      echo "Running KVCACHE for $dataset, maxKnowledge $k, maxParagraph $p, maxQuestion $maxQuestion, model $model"
      echo "Running KVCACHE for $dataset, maxKnowledge $k, maxParagraph $p, maxQuestion $maxQuestion, model $model" >> $logfilename
      python ./kvcache.py --kvcache file --dataset "$dataset" --similarity bertscore \
        --maxKnowledge "$k" --maxParagraph "$p" --maxQuestion "$maxQuestion" \
        --modelname "meta-llama/Llama-${model}-Instruct" --randomSeed  "$randomSeed" \
        --output "./random_results/${dataset}/k${k}/result_${model}_k${k}_p${p}_q${maxQuestion}_${dataset}_bertscore_kvcache.txt_${i}"
      
      # Run RAG
      for topk in "${top_k[@]}"; do
          for index in "${indices[@]}"; do
            echo "Running RAG with $index for $dataset, maxKnowledge $k, maxParagraph $p, maxQuestion $maxQuestion, model $model, topk ${topk}"
            echo "Running RAG with $index for $dataset, maxKnowledge $k, maxParagraph $p, maxQuestion $maxQuestion, model $model, topk ${topk}" >> $logfilename
            python ./rag.py --index "$index" --dataset "$dataset" --similarity bertscore \
              --maxKnowledge "$k" --maxParagraph "$p" --maxQuestion "$maxQuestion" --topk "$topk" \
              --modelname "meta-llama/Llama-${model}-Instruct" --randomSeed  "$randomSeed" \
              --output "./random_results/${dataset}/k${k}/result_${model}_k${k}_p${p}_q${maxQuestion}_${dataset}_bertscore_rag_Index_${index}_top${topk}.txt_${i}" 
          done
      done
      
    done
  done
done

logfilename="./log/random-squad-k3.log"
# while log file exists, create a new one called random_i.log
i=1
while [ -f $logfilename ]; do
    echo "log file ${logfilename} exists, create a new one"
    logfilename="./log/random-squad$i-k3_$i.log"
    i=$(($i+1))
done

# datasets=("squad-train")
# when k = 3, tokens = 21,000
# when k = 4, tokens = 32,000
# when k = 7, tokens = 50,000

# 在這裡自訂 k 和 p 的值
k=7  # 設定 k 值
p=100  # 設定 p 值

datasets=("squad-train")
# models=("3.1-8B" "3.2-3B" "3.2-1B")
models=("3.1-8B")
indices=("openai" "bm25")
maxQuestions=("500")
top_k=("1" "3" "5" "10" "20")

for dataset in "${datasets[@]}"; do
  for model in "${models[@]}"; do
    for maxQuestion in "${maxQuestions[@]}"; do
      
      randomSeed=$(shuf -i 1-100000 -n 1)
      echo "Random seed: $randomSeed" >> $logfilename

      # Run KVCACHE without cache
      echo "Running KVCACHE for $dataset, maxKnowledge $k, maxParagraph $p, maxQuestion $maxQuestion, model $model"
      echo "Running KVCACHE for $dataset, maxKnowledge $k, maxParagraph $p, maxQuestion $maxQuestion, model $model" >> $logfilename
      python ./kvcache.py --kvcache file --dataset "$dataset" --similarity bertscore \
        --maxKnowledge "$k" --maxParagraph "$p" --maxQuestion "$maxQuestion" --usePrompt \
        --modelname "meta-llama/Llama-${model}-Instruct" --randomSeed  "$randomSeed" \
        --output "./random_results/${dataset}/k${k}/result_${model}_k${k}_p${p}_q${maxQuestion}_${dataset}_bertscore_kvcache_nokv.txt_${i}"
      
      # Run KVCACHE
      echo "Running KVCACHE for $dataset, maxKnowledge $k, maxParagraph $p, maxQuestion $maxQuestion, model $model"
      echo "Running KVCACHE for $dataset, maxKnowledge $k, maxParagraph $p, maxQuestion $maxQuestion, model $model" >> $logfilename
      python ./kvcache.py --kvcache file --dataset "$dataset" --similarity bertscore \
        --maxKnowledge "$k" --maxParagraph "$p" --maxQuestion "$maxQuestion" \
        --modelname "meta-llama/Llama-${model}-Instruct" --randomSeed  "$randomSeed" \
        --output "./random_results/${dataset}/k${k}/result_${model}_k${k}_p${p}_q${maxQuestion}_${dataset}_bertscore_kvcache.txt_${i}"
      
      # Run RAG
      for topk in "${top_k[@]}"; do
          for index in "${indices[@]}"; do
            echo "Running RAG with $index for $dataset, maxKnowledge $k, maxParagraph $p, maxQuestion $maxQuestion, model $model, topk ${topk}"
            echo "Running RAG with $index for $dataset, maxKnowledge $k, maxParagraph $p, maxQuestion $maxQuestion, model $model, topk ${topk}" >> $logfilename
            python ./rag.py --index "$index" --dataset "$dataset" --similarity bertscore \
              --maxKnowledge "$k" --maxParagraph "$p" --maxQuestion "$maxQuestion" --topk "$topk" \
              --modelname "meta-llama/Llama-${model}-Instruct" --randomSeed  "$randomSeed" \
              --output "./random_results/${dataset}/k${k}/result_${model}_k${k}_p${p}_q${maxQuestion}_${dataset}_bertscore_rag_Index_${index}_top${topk}.txt_${i}" 
          done
      done
      
    done
  done
done

echo "Finished running random-squad.sh" >> $logfilename