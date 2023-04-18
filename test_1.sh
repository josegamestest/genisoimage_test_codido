#!/bin/bash

# Criando janela principal
yad --form --title "Criar imagem ISO com genisoimage" \
    --width 500 --height 300 \
    --field "Diretório de origem:DIR" "." \
    --field "Arquivo de saída:FL" "" \
    --field "Opções:" "" \
    --button "Criar imagem ISO":0 \
    --button "Cancelar":1 \
    --separator="," \
    > /tmp/genisoimage.txt

# Lendo os dados do formulário
DIR=$(cat /tmp/genisoimage.txt | cut -d ',' -f 1)
SAIDA=$(cat /tmp/genisoimage.txt | cut -d ',' -f 2)
OPCOES=$(cat /tmp/genisoimage.txt | cut -d ',' -f 3)

# Criando a imagem ISO com genisoimage
genisoimage -r -J -o "$SAIDA" "$DIR" $OPCOES

# Exibindo mensagem de sucesso
yad --title "Concluído!" \
    --text "A imagem ISO foi criada com sucesso em: $SAIDA" \
    --button "OK":0
