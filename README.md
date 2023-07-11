# MysqlBackup

#!/bin/bash

base_dir="/home/amaralchr/Mysql" #Coloca o destino que voce quer cirar para realizar o backup
pasta1="$base_dir/pasta1" #CRiei tres pastas cada uma delas vai armazenar o backup cada vez que rodar, então são minhas váriaveis para represtar no final do código
pasta2="$base_dir/pasta2"
pasta3="$base_dir/pasta3"

if [ ! -d "$base_dir" ]; then #Se caso não tiver o diretorio acima ele vai criar
  mkdir -p "$base_dir"
fi

temp_dir="$base_dir/.temp"

if [ ! -d "$temp_dir" ]; then #Se caso não tiver a pasta .temp que seria a tempóraria ela cria
  mkdir -p "$temp_dir"
fi

backup_file="$temp_dir/backup_$(date +%Y-%m-%d_%H%M%S).sql" #esse não vai ser compactado e estara na pasta .temp e na pasta1 o arquivo compactado

export MYSQL_PWD="Senha123" #Coloquei um export para deixar a senha como uma váriavel para realizar a execução do container docker abaixo.

docker exec mysql-A sh -c "exec mysqldump -uroot -p\$MYSQL_PWDaluno" > "$backup_file" #Sempre deixar junto -u seria usúario do Mysql e depois do -p é a senha com o nome do banco

zip "$backup_file.zip" "$backup_file"

stored_folder="" #essa é a regra das pastas que quando uma tiver backup da .temp ele vai rotacionar e se caso algumas das tres pastas não tiver, ele também vai criar
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

echo "Backup realizado, compactado e rotacionado" #retorno na tela
