#!/bin/bash

# Uso:
# ./myscript.sh up 2 subtitle.srt
# ./myscript.sh down 3.5 subtitle.srt

if [ $# -ne 3 ]; then
    echo "Uso: $0 <up|down> <segundos> <archivo.srt>"
    exit 1
fi

ACTION="$1"
SHIFT="$2"
INPUT="$3"

if [ ! -f "$INPUT" ]; then
    echo "Error: no existe el archivo '$INPUT'"
    exit 1
fi

# Convertir segundos a milisegundos
SHIFT_MS=$(awk "BEGIN { printf \"%d\", $SHIFT * 1000 }")

# Nombre de salida
OUTPUT="${INPUT%.srt}_shifted.srt"

convert_time_to_ms() {
    local T="${1//$'\r'/}"

    IFS=':,' read -r H M S MS <<< "$T"

    echo $((10#$H * 3600000 + 10#$M * 60000 + 10#$S * 1000 + 10#$MS))
}

convert_ms_to_time() {
    local TOTAL=$1

    if [ "$TOTAL" -lt 0 ]; then
        TOTAL=0
    fi

    local H=$((TOTAL / 3600000))
    TOTAL=$((TOTAL % 3600000))

    local M=$((TOTAL / 60000))
    TOTAL=$((TOTAL % 60000))

    local S=$((TOTAL / 1000))
    local MS=$((TOTAL % 1000))

    printf "%02d:%02d:%02d,%03d" "$H" "$M" "$S" "$MS"
}

while IFS= read -r LINE; do
    LINE="${LINE//$'\r'/}"
    if [[ "$LINE" == *" --> "* ]]; then
        START="${LINE%% --> *}"
        END="${LINE##* --> }"

        START_MS=$(convert_time_to_ms "$START")
        END_MS=$(convert_time_to_ms "$END")

        if [ "$ACTION" = "up" ]; then
            START_MS=$((START_MS + SHIFT_MS))
            END_MS=$((END_MS + SHIFT_MS))
        else
            START_MS=$((START_MS - SHIFT_MS))
            END_MS=$((END_MS - SHIFT_MS))
        fi

        echo "$(convert_ms_to_time "$START_MS") --> $(convert_ms_to_time "$END_MS")"
    else
        echo "$LINE"
    fi
done < "$INPUT" > "$OUTPUT"

echo "Subtítulo corregido guardado en:"
echo "  $OUTPUT"