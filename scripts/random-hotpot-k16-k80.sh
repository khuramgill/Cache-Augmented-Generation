#!/bin/bash
logfilename="./log/random-hotpot-k16-k80.log"
# while log file exists, create a new one called random_i.log
i=1
while [ -f $logfilename ]; do
    echo "log file ${logfilename} exists, create a new one"
    logfilename="./log/random-hotpot-k16-k80_$i.log"
    i=$(($i+1))
done

# # all k = 7405 article, tokens = 10,038,084 
# # when k = 1, tokens = 1,400
# # when k = 16, tokens = 22,400
# # when k = 24, tokens = 33,667
# # when k = 32, tokens = 44,800
# # when k = 48, tokens = 64,000
# # when k = 64, tokens = 85,000
# # when k = 80, tokens = 106,000

datasets=("hotpotqa-train")
# models=("3.1-8B" "3.2-3B" "3.2-1B")
models=("3.1-8B")
indices=("openai" "bm25")
# k=("16" "32" "48" "64" "80")
k=("16")
maxQuestions=("500")
top_k=("1" "3" "5" "10" "20")


for dataset in "${datasets[@]}"; do
  for model in "${models[@]}"; do
    for maxQuestion in "${maxQuestions[@]}"; do
      batch=k 
      # iteration = maxQuestion / batch
      iteration=$(($maxQuestion / $batch))

      for i in $(seq 1 $iteration); do
        randomSeed=$(shuf -i 1-100000 -n 1)
        echo "Random seed: $randomSeed" >> $logfilename

        # Run KVCACHE without cache
        echo "Running KVCACHE for $dataset, maxQuestion $maxQuestion, model $model"
        echo "Running KVCACHE for $dataset, maxQuestion $maxQuestion, model $model" >> $logfilename
        python ./kvcache.py --kvcache file --dataset "$dataset" --similarity bertscore \
          --maxKnowledge "$k" --maxQuestion "$k" --usePrompt \
          --modelname "meta-llama/Llama-${model}-Instruct" --randomSeed  "$randomSeed" \
          --output "./random_results/${dataset}/${k}/result_${model}_k${k}_q${maxQuestion}_${dataset}_bertscore_kvcache_nokv.txt_${i}"

        # Run KVCACHE
        echo "Running KVCACHE for $dataset, maxQuestion $maxQuestion, model $model"
        echo "Running KVCACHE for $dataset, maxQuestion $maxQuestion, model $model" >> $logfilename
        python ./kvcache.py --kvcache file --dataset "$dataset" --similarity bertscore \
          --maxKnowledge "$k" --maxQuestion "$k" \
          --modelname "meta-llama/Llama-${model}-Instruct" --randomSeed  "$randomSeed" \
          --output "./random_results/${dataset}/${k}/result_${model}_k${k}_q${maxQuestion}_${dataset}_bertscore_kvcache.txt_${i}"
        
        # Run RAG
        for topk in "${top_k[@]}"; do
            for index in "${indices[@]}"; do
              echo "Running RAG with $index for $dataset, maxKnowledge $k, maxParagraph $p, maxQuestion $maxQuestion, model $model, topk ${topk}"
              echo "Running RAG with $index for $dataset, maxKnowledge $k, maxParagraph $p, maxQuestion $maxQuestion, model $model, topk ${topk}" >> $logfilename
              python ./rag.py --index "$index" --dataset "$dataset" --similarity bertscore \
                --maxKnowledge "$k" --maxQuestion "$k" --topk "$topk" \
                --modelname "meta-llama/Llama-${model}-Instruct" --randomSeed  "$randomSeed" \
                --output "./random_results/${dataset}/${k}/result_${model}_k${k}_q${maxQuestion}_${dataset}_bertscore_rag_Index_${index}_top${topk}.txt_${i}" 
            done
        done

      done
    done
  done
done

datasets=("hotpotqa-train")
# models=("3.1-8B" "3.2-3B" "3.2-1B")
models=("3.1-8B")
indices=("openai" "bm25")
# k=("16" "32" "48" "64" "80")
k=("80")
maxQuestions=("500")
top_k=("1" "3" "5" "10" "20")

for dataset in "${datasets[@]}"; do
  for model in "${models[@]}"; do
    for maxQuestion in "${maxQuestions[@]}"; do
      batch=k 
      # iteration = maxQuestion / batch
      iteration=$(($maxQuestion / $batch))

      for i in $(seq 1 $iteration); do
        randomSeed=$(shuf -i 1-100000 -n 1)
        echo "Random seed: $randomSeed" >> $logfilename

        # Run KVCACHE without cache
        echo "Running KVCACHE for $dataset, maxQuestion $maxQuestion, model $model" >> $logfilename
        python ./kvcache.py --kvcache file --dataset "$dataset" --similarity bertscore \
          --maxKnowledge "$k" --maxQuestion "$k" --usePrompt \
          --modelname "meta-llama/Llama-${model}-Instruct" --randomSeed  "$randomSeed" \
          --output "./random_results/${dataset}/${k}/result_${model}_k${k}_q${maxQuestion}_${dataset}_bertscore_kvcache_nokv.txt_${i}"

        # Run KVCACHE
        echo "Running KVCACHE for $dataset, maxQuestion $maxQuestion, model $model" >> $logfilename
        python ./kvcache.py --kvcache file --dataset "$dataset" --similarity bertscore \
          --maxKnowledge "$k" --maxQuestion "$k" \
          --modelname "meta-llama/Llama-${model}-Instruct" --randomSeed  "$randomSeed" \
          --output "./random_results/${dataset}/${k}/result_${model}_k${k}_q${maxQuestion}_${dataset}_bertscore_kvcache.txt_${i}"
        
        # Run RAG
        for topk in "${top_k[@]}"; do
            for index in "${indices[@]}"; do
              echo "Running RAG with $index for $dataset, maxKnowledge $k, maxParagraph $p, maxQuestion $maxQuestion, model $model, topk ${topk}" >> $logfilename
              python ./rag.py --index "$index" --dataset "$dataset" --similarity bertscore \
                --maxKnowledge "$k" --maxQuestion "$k" --topk "$topk" \
                --modelname "meta-llama/Llama-${model}-Instruct" --randomSeed  "$randomSeed" \
                --output "./random_results/${dataset}/${k}/result_${model}_k${k}_q${maxQuestion}_${dataset}_bertscore_rag_Index_${index}_top${topk}.txt_${i}" 
            done
        done
      

      done
    done
  done
done

echo "All done" >> $logfilename