#!/bin/bash

# squad dataset
curl -L -o ./datasets/squad/stanford-question-answering-dataset.zip\
  https://www.kaggle.com/api/v1/datasets/download/stanfordu/stanford-question-answering-dataset
unzip ./datasets/squad/stanford-question-answering-dataset.zip -d ./datasets/squad/
rm ./datasets/squad/stanford-question-answering-dataset.zip

# hotpotqa dataset
curl -L -o ./datasets/hotpotqa/hotpotqa-question-answering-dataset.zip\
  https://www.kaggle.com/api/v1/datasets/download/jeromeblanchet/hotpotqa-question-answering-dataset
unzip ./datasets/hotpotqa/hotpotqa-question-answering-dataset.zip -d ./datasets/hotpotqa/
rm ./datasets/hotpotqa/hotpotqa-question-answering-dataset.zip
