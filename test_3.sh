#!/bin/bash

# Função para selecionar o diretório
function selecionar_diretorio() {
    dir=$(yad --title "Selecione o diretório" --file --directory)
    if [[ $? -eq 0 ]]; then
        cd $dir
    fi
}

# Função para gerar a imagem ISO
function gerar_iso() {
    nome=$(yad --title "Gerar imagem ISO" --entry --text "Digite o nome da imagem ISO:")
    if [[ $? -ne 0 ]]; then
        return
    fi

    caminho=$(yad --title "Gerar imagem ISO" --file --save --confirm-overwrite --filename="$nome.iso")
    if [[ $? -ne 0 ]]; then
        return
    fi

    genisoimage -iso-level 3 -r -udf -o "$caminho" .
    if [[ $? -eq 0 ]]; then
        yad --title "Gerar imagem ISO" --info --text "Imagem ISO gerada com sucesso!"
    else
        yad --title "Gerar imagem ISO" --error --text "Erro ao gerar imagem ISO"
    fi
}

# Interface principal
yad --title "Gerador de imagens ISO" --form --field="Diretório:DIR" \
--field="Gerar ISO:BTN" \
--button="Selecionar Diretório":1 --button="Fechar":0 \
--field-separator=" " --field="Mensagem:LBL" \
--text="Selecione o diretório que deseja gerar a imagem ISO" \
--button="Gerar ISO":2 --buttons-layout=center \
--on-top --center --width=500 --height=200 \
--form-info="<b>Atenção:</b> A imagem ISO será gerada a partir dos arquivos contidos no diretório selecionado." \
--field="<b>Observação:</b>":LBL "" \
--field="<b>Notificação:</b>":LBL "Escolha um diretório para continuar."

# Verifica qual botão foi clicado
case $? in
    1) selecionar_diretorio;;
    2) gerar_iso;;
esac
