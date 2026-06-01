#!/bin/bash

# Запрос исходной и целевой директории у пользователя
read -p "Введите исходную директорию: "  source_directory
read -p "введите целевую директорию: " target_directory

# Запрос расширения файлов, которые нужно скопировать
read -p "Введите расширение:  " file_extension

# Запросить новое расширение для файлов.

echo "Enter new file extension:"
read new_file_extension

# Проверка существования исходной директории и целевой директории
if [ ! -d "$source_directory" ]; then
    echo "Ошибка: исходная директория не существует"
    exit 1
fi

if [ ! -r "$source_directory" ] || [ ! -x "$source_directory" ]; then
    echo "Ошибка: исходная директория недоступна"
    exit 1
fi

if [ ! -d "$target_directory" ]; then
    echo "Ошибка: целевая директория не существует"
    exit 1
fi

if [ ! -r "$target_directory" ] || [ ! -x "$target_directory" ]; then
    echo "Ошибка: целевая директория недоступна"
    exit 1
fi

echo "Исходная и целевая директории существуют и доступны"

# Проверка, есть ли файлы с указанным расширением в исходной директории


files=$(find "$source_directory" -type f -name "*.$file_extension")

if [ -z "$files" ]; then
    echo "Ошибка: файлы с расширением .$file_extension не найдены в директории $source_directory"
    exit 1
fi

# Копирование файлов с указанным расширением в целевую директорию
files=("$source_directory"/*."$file_extension")

for file in "${files[@]}"; do
    filename=$(basename "$file" ".$file_extension")

    cp "$file" "$target_directory/$filename.$new_file_extension"
    
echo "Скопирован файл: $(basename "$file") > $filename.$new_file_extension"
done

#issue-7-archive
archive_name="old_files_$(date +%Y-%m-%d).tar.gz"

tar -czf "$target_directory/$archive_name" "$source_directory"/*."$file_extension"

rm -f "$source_directory"/*."$file_extension"

echo "Archive created: $target_directory/$archive_name"
echo "Source files deleted"

