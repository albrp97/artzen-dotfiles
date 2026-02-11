#!/bin/bash

# 1. Obtener condición y temperatura
# %C = Texto condición, %t = Temperatura
line=$(curl -s "wttr.in/Granada?format=%C:%t")

# Separar variables
condition=$(echo "$line" | cut -d':' -f1)
temp=$(echo "$line" | cut -d':' -f2)

# 2. Normalizar a minúsculas para comparar
cond_lower=$(echo "$condition" | tr '[:upper:]' '[:lower:]')

# 3. Elegir icono de Nerd Font (Iconos de texto que SÍ se colorean)
icon="" # Sol por defecto

if [[ "$cond_lower" == *"partly"* || "$cond_lower" == *"cloud"* || "$cond_lower" == *"overcast"* ]]; then
    icon=" "
elif [[ "$cond_lower" == *"rain"* || "$cond_lower" == *"drizzle"* || "$cond_lower" == *"shower"* ]]; then
    icon=" "
elif [[ "$cond_lower" == *"snow"* ]]; then
    icon=" "
elif [[ "$cond_lower" == *"storm"* || "$cond_lower" == *"thunder"* ]]; then
    icon=" "
elif [[ "$cond_lower" == *"fog"* || "$cond_lower" == *"mist"* ]]; then
    icon=" "
fi

# 4. Obtener Tooltip
tooltip=$(curl -s "wttr.in/Granada?format=%C+%t+\nWind:+%w\nHumidity:+%h")

# 5. ARREGLO DEL ERROR JSON:
# Escapar saltos de línea (convertir 'enter' real en '\n' texto) y comillas
tooltip=$(echo "$tooltip" | sed ':a;N;$!ba;s/\n/\\n/g' | sed 's/"/\\"/g')

# 6. Imprimir JSON válido
echo "{\"text\": \"$icon $temp\", \"tooltip\": \"$tooltip\"}"