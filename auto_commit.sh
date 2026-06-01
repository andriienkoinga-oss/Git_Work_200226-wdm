#!/bin/bash

REPO=$(find . -type d -name ".git")
AUTO_COMMIT=$(date +'%Y-%m-%d %H:%M:%S')

if [ -z "$REPO" ]; then
  echo "Текущая директория не содержит репозиторий гит"
  exit 
fi 

git add .

if [ git diff-index --quiet HEAD ]; then
  echo "Нет изменений для фиксации в репозитории Git"
  exit
fi

git commit -m "$AUTO_COMMIT"
echo "Успешное фиксирование изменений"

