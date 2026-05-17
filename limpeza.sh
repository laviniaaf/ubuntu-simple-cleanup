#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "sudo bash limpeza.sh"
    exit 1
fi

echo "============================================="
echo " iniciando cleaning cache: $(date '+%H:%M:%S')"
echo "============================================="

echo "1. limpando o cache de ram"
# o linux guarda os dados do disco na ram para acelerar acessos futuros (pagecache),
# e tambem nomes de arquivos e pastas em memória (dentries e inodes)
# o "sync" grava no disco tudo que ainda esta pendente na memória,
# evitando a perda de dados antes de limpar o cache de ram,
# o "echo 3" escreve o valor 3 no arquivo especial do kernel /proc/sys/vm/drop_caches,
# que instrui o sistema a liberar os três tipos de cache de memória:
#   1 = pagecache (dados de arquivos em cache)
#   2 = dentries e inodes (estrutura de diretórios e metadados)
#   3 = os dois acima ao mesmo tempo
sync
echo 3 > /proc/sys/vm/drop_caches

echo "2. limpando o cache do apt"
apt-get clean -y     
apt-get autoclean -y   

echo "3. removendo pacotes desnecessários"
apt-get autoremove -y 

echo "4. limpando logs do sistema de mais de sete dias"
journalctl --vacuum-time=7d 

# no ubuntu fica guardado miniaturas de fotos/vídeos (thumbnails) em cache pra carregar mais rápido, 
# mas não apaga quando você deleta o arquivo original
echo "5. removendo thumbnails de mais de trinta dias"
find /home/*/.cache/thumbnails -type f -atime +30 -delete

echo "============================================="
echo " limpeza concluida com sucesso!"
echo " $(date '+%d/%m/%Y %H:%M:%S')"
echo "============================================="
