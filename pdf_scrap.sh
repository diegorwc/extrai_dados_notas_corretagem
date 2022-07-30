#!/bin/bash
echo > txt
for FILE in 2022/*.pdf
do 
    REPLACE_TXT=`echo $FILE | cut -d/ -f2 | sed 's/pdf/txt/g'`
    DATA=`java -jar tabula-1.0.5-jar-with-dependencies.jar $FILE` 
    FILTRO_BOV=`echo "$DATA" | grep 'BOV' | sed -E 's/SPA V/SPA,V/g'`
    DATA_OPERACAO=`echo "$DATA" | grep -E -o ',,[0-9]{2}/[0-9]{2}/[0-9]{4}' | sed -E 's/,,//g'`     
    QUANTIDADE_ATIVOS_NOTA=`echo "$FILTRO_BOV" | wc -l`

    while IFS= read -r line
    do
        DATA_FOR_CUT=`echo $line | sed -E 's/SPA C/SPA,C/g;s/,+/,/g;s/FRACIONARIO //g;s/ ([0-9]+),/,\1,/g;s/1-BOVESPA,//g;s/ D"/",D/g;s/[# ]//g;s/"([0-9]+),([0-9]+)"/\1.\2/g'`        
        OPERACAO=`echo $DATA_FOR_CUT | cut -d, -f1`
        CODIGO_ATIVO=`echo $DATA_FOR_CUT | cut -d, -f2`
        if [[ "$CODIGO_ATIVO" == *"PN"* ]]; then
            if [[ "$CODIGO_ATIVO" == *"ALUP"* ]]; then
                CODIGO=ALUP4
            fi
            if [[ "$CODIGO_ATIVO" == *"ITAUS"* ]]; then
                CODIGO=ITSA4
            fi
            if [[ "$CODIGO_ATIVO" == *"INTER"* ]]; then
                CODIGO=BIDI4
            fi
            if [[ "$CODIGO_ATIVO" == *"PETR"* ]]; then
                CODIGO=PETR4
            fi
            if [[ "$CODIGO_ATIVO" == *"TAESA"* ]]; then
                CODIGO=TAEE4
            fi
            if [[ "$CODIGO_ATIVO" == *"KLAB"* ]]; then
                CODIGO=KLBN4
            fi
            if [[ "$CODIGO_ATIVO" == *"SANEP"* ]]; then
                CODIGO=SAPR4
            fi
            if [[ "$CODIGO_ATIVO" == *"BANRIS"* ]]; then
                CODIGO=BRSR5
            fi
        fi
        if [[ "$CODIGO_ATIVO" == *"UNT"* ]]; then
            if [[ "$CODIGO_ATIVO" == *"SULA"* ]]; then
                CODIGO=SULA11
            fi
            if [[ "$CODIGO_ATIVO" == *"BTG"* ]]; then
                CODIGO=BPAC11
            fi
            if [[ "$CODIGO_ATIVO" == *"ALUP"* ]]; then
                CODIGO=ALUP11
            fi
        fi
        if [[ "$CODIGO_ATIVO" == *"ON"* ]]; then
            if [[ "$CODIGO_ATIVO" == *"RIO"* ]]; then
                CODIGO=PRIO3
            fi
            if [[ "$CODIGO_ATIVO" == *"VIA"* ]]; then
                CODIGO=VIIA3
            fi
            if [[ "$CODIGO_ATIVO" == *"AMBEV"* ]]; then
                CODIGO=ABEV3
            fi        
            if [[ "$CODIGO_ATIVO" == *"ENGIE"* ]]; then
                CODIGO=EGIE3
            fi    
            if [[ "$CODIGO_ATIVO" == *"SLC"* ]]; then
                CODIGO=SLCE3
            fi    
            if [[ "$CODIGO_ATIVO" == *"BBSE"* ]]; then
                CODIGO=BBSE3
            fi
            if [[ "$CODIGO_ATIVO" == *"CSNM"* ]]; then
                CODIGO=CMIN3
            fi
            if [[ "$CODIGO_ATIVO" == *"WEG"* ]]; then
                CODIGO=WEGE3
            fi
            if [[ "$CODIGO_ATIVO" == *"COSAN"* ]]; then
                CODIGO=CSAN3
            fi
            if [[ "$CODIGO_ATIVO" == *"JBS"* ]]; then
                CODIGO=JBSS3
            fi
            if [[ "$CODIGO_ATIVO" == *"MULTI"* ]]; then
                CODIGO=MULT3
            fi
            if [[ "$CODIGO_ATIVO" == *"TOTV"* ]]; then
                CODIGO=TOTS3
            fi
            if [[ "$CODIGO_ATIVO" == *"BRASIL"* ]]; then
                CODIGO=BBAS3
            fi
            if [[ "$CODIGO_ATIVO" == *"EQUAT"* ]]; then
                CODIGO=EQTL3
            fi
            if [[ "$CODIGO_ATIVO" == *"B3"* ]]; then
                CODIGO=B3SA3
            fi
            if [[ "$CODIGO_ATIVO" == *"RENN"* ]]; then
                CODIGO=LREN3
            fi
            if [[ "$CODIGO_ATIVO" == *"NEOENERG"* ]]; then
                CODIGO=NEOE3
            fi
            if [[ "$CODIGO_ATIVO" == *"SANTAND"* ]]; then
                CODIGO=SANB3
            fi
        fi
        if [[ "$CODIGO_ATIVO" == *"BITCOIN"* ]]; then
                CODIGO=QBTC11
        fi
        if [[ "$CODIGO_ATIVO" == *"VISTAINTER"* ]]; then
                CODIGO=INBR31
            fi
        # echo $CODIGO
        if [[ $CODIGO == "" ]]; then
            $CODIGO_ATIVO
        fi
        QUANTIDADE=`echo $DATA_FOR_CUT | cut -d, -f3`
        PRECO_UNITARIO=`echo $DATA_FOR_CUT | cut -d, -f4`
        echo $DATA_OPERACAO,AÇÕES,$CODIGO,$OPERACAO,$QUANTIDADE,$PRECO_UNITARIO,RICO INVESTIMENTOS >> acoes.csv
        CODIGO=""
    done <<< "$FILTRO_BOV"    
done    