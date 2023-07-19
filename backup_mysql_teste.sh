#!/bin/bash

base_dir="/home/ubuntu/Mysql"
pasta1="$base_dir/pasta1"
pasta2="$base_dir/pasta2"
pasta3="$base_dir/pasta3"

if [ ! -d "$base_dir" ]; then
  mkdir -p "$base_dir"
fi

temp_dir="$base_dir/.temp"

if [ ! -d "$temp_dir" ]; then
  mkdir -p "$temp_dir"
fi

backup_file="$temp_dir/backup_$(date +%Y-%m-%d_%H%M%S).sql"

export MYSQL_PWD="Senha123"
docker exec mysql-A sh -c "exec mysqldump -uroot -p\$MYSQL_PWDmysql" > "$backup_file"

zip "$backup_file.zip" "$backup_file"

stored_folder=""
if [ ! -d "$pasta1" ]; then
  mkdir -p "$pasta1"
  stored_folder="$pasta1"
elif [ ! -d "$pasta2" ]; then
  mkdir -p "$pasta2"
  stored_folder="$pasta2"
elif [ ! -d "$pasta3" ]; then
  mkdir -p "$pasta3"
  stored_folder="$pasta3"
else
  stored_folder="$pasta1"
fi

mv "$backup_file.zip" "$stored_folder/backup.zip"

echo "Backup realizado, compactado e rotacionado"
