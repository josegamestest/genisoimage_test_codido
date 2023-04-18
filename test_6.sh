#!/bin/bash

INPUT=$(yad --file --directory --title="Selecione o diretório de entrada" --width=600 --height=400)
OUTPUT=$(yad --file --directory --title="Selecione o diretório de saída" --width=600 --height=400)
ISO_NAME=$(yad --title="Nome do arquivo ISO" --text="Digite o nome do arquivo ISO" --entry)

UDF_OPTIONS=("2.01" "2.50" "2.60")
UDF_VERSION=$(yad --title="Versão do sistema de arquivos UDF" --text="Selecione a versão do sistema de arquivos UDF" --list --column="Versão" "${UDF_OPTIONS[@]}")

LEVEL_OPTIONS=("1" "2" "3")
LEVEL=$(yad --title="Nível de saída" --text="Selecione o nível de saída" --list --column="Nível" "${LEVEL_OPTIONS[@]}")

MD5_CHECKBOX=$(yad --title="MD5" --text="Gerar soma de verificação MD5?" --checkbox)

GENISO_CMD="genisoimage -iso-level $LEVEL -r -udf $UDF_VERSION -o '$OUTPUT/$ISO_NAME' '$INPUT'"


if [ "$MD5_CHECKBOX" = "TRUE" ]; then
    GENISO_CMD="$GENISO_CMD -hash md5"
fi
echo "Comando gerado: $GENISO_CMD"
yad --title="Gerar imagem ISO" --text="Deseja gerar a imagem ISO?" --button="Sim:0" --button="Não:1" --width=300 --height=100

if [ "$?" = "0" ]; then
    eval "$GENISO_CMD"
    if [ "$?" = "0" ]; then
    echo "ISO gerada com sucesso em $OUTPUT/$ISO_NAME"
    else
        echo "Falha ao gerar ISO"
    fi
    yad --title="Concluído" --text="A imagem ISO foi gerada com sucesso em $OUTPUT/$ISO_NAME" --button="OK:0" --width=300 --height=100
fi
