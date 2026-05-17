# ubuntu-simple-cleanup

script simples de limpeza de cache para ubuntu.

## O que ele faz:

1 - Limpa o cache de ram e libera pagecache, dentries e inodes acumulados pelo kernel  
2 - Limpa o cache do apt e remove pacotes .deb baixados que não são mais necessários  
3 - Remove pacotes órfãos e desinstala dependências que não são usadas por nenhum programa  
4 - Limpa logs do sistema apagando entradas do journald com mais de sete dias  
5 - Remove thumbnails antigos (não acessados há mais de trinta dias).  

## Como usar:

```bash
# 1. clonar o repositório
git clone <link_repositorio>

# 2. entrar na pasta
cd ubuntu-simple-cleanup

# 3. dar permissão de execução ao script
chmod +x limpeza.sh

# 4. executar
sudo bash limpeza.sh
```