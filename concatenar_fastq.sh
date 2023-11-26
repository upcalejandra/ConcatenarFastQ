#!/bin/bash

# Autores:	Alejandra León y Sebastián Leyva
# Curso:		Principios de Programación Bioinformática

# Fecha de creación:	25/11/2023
# Nombre del proyecto:	Concatenación de archivos FastQ
# Descripción:			Concatenar archivos FastQ en uno solo y realizar opciones adicionales relacionadas a archivos FastQ

## Función principal: Concatenar archivos FastQ

        # Verificar de que se esté proporcionando más de un archivo

            if [ "$#" -lt 2 ]; then
                echo "Error: Se necesita más de un archivo para poder concatenar"
                exit 1
            fi

        # Verificar que los archivos sean FastQ

            for archivo in "$@"
            do
	            if [[ "$archivo" != *.fastq ]]
	        then
		        echo "Error: Los archivos que has proporcionado no se encuentran en formato FastQ"
		        exit 1
	            fi
            done

        # Proporcionar nombre del archivo de salida

                read -p "Escribe el nombre del archivo final concatenado (sin terminación .fastq): " archivo_concatenado

        # Indicar que se están concatenando los archivos

                echo "Concatenando los archivos FastQ..."

        # Concatenar los archivos FASTQ proporcionados en un solo archivo y en el directorio actual

            cat "$@" > "./$archivo_concatenado.fastq"

            if [ $? -eq 0 ]; then
	                echo "¡Felicidades! Tus archivos $@ han sido concatenados con éxito en $archivo_concatenado.fastq ubicado en $(pwd)"
            else
                    echo "Error: No se pudo concatenar los archivos. Verifica su nombre y contenido."
            fi

# Selección de opciones
echo "Selecciona una opción:"
echo "1. Conversion de Archivo "FastQ" a archivo "Fasta""
echo "2. Imprimir Stats del archivo "FastQ" generado"
echo "3. Contabiliza los codones "ATG" dentro del archivo "FastQ" generado"
echo "4. Identifica posibles ORFs dentro del archivo concatenado "FastQ" "
read option

# Opciones adicionales
case $option in
    1)
        ## Función adicional 01: Convertir el archivo FastQ concatenado a Fasta y calcular estadísticas
        # Convertir el archivo FastQ concatenado a Fasta
        awk 'BEGIN {FS=" "} NR%4==1 {print ">"$1,$NF; next} NR%4==2 {print}' "$archivo_concatenado.fastq" > "$archivo_concatenado.fasta"

        echo "¡Felicidades! Lograste convertir tu archivo $archivo_concatenado.fastq a $archivo_concatenado.fasta."
    
        # Nombre del archivo FASTA
            archivo_fasta="$archivo_concatenado.fasta" 

        # Obtener solo la secuencia desde el archivo FASTA (sin encabezado)
            sequence=$(awk '/^[^>]/ { printf "%s", $0 }' "$archivo_fasta")

        # Calcular el tamaño de la secuencia
            sequence_size=$(echo -n "$sequence" | wc -c)

        # Contar el número de G y C en la secuencia
            gc_count=$(echo -n "$sequence" | grep -o '[GCgc]' | wc -l)

        # Verifica si bc está instalado
            if ! command -v bc &> /dev/null; then
                echo "bc no está instalado. Instalando..."
                sudo apt-get update
                sudo apt-get install bc -y
                echo "bc se ha instalado correctamente."
            else
                echo "bc ya está instalado."
            fi

        # Calcular el porcentaje de GC y AT
            gc_percentage=$(echo "scale=2; ($gc_count / $sequence_size) * 100" | bc)
            at_percentage=$(echo "scale=2; 100 - $gc_percentage" | bc)

        # Imprimir resultados
            echo "Porcentaje de GC: $gc_percentage%"
            echo "Porcentaje de AT: $at_percentage%"
            echo "Tamaño de la secuencia: $sequence_size bases"
        ;;
    2)
        ## Función adicional 02: Calcular estadísticas del archivo FastQ concatenado
        # Extraer las secuencias de ADN del archivo FastQ
            secuencias=$(awk 'NR%4==2' "$archivo_concatenado.fastq")

        # Inicializar contadores
            total_bases=0
            gc_bases=0
            at_bases=0

        # Calcular el tamaño total de la secuencia y contar los nucleótidos
            while read -r secuencia; do
                total_bases=$((total_bases + ${#secuencia}))
                gc_bases=$((gc_bases + $(echo "$secuencia" | tr -cd 'GC' | wc -m)))
                at_bases=$((at_bases + $(echo "$secuencia" | tr -cd 'AT' | wc -m)))
            done <<< "$secuencias"
        # Verifica si bc está instalado
            if ! command -v bc &> /dev/null; then
                echo "bc no está instalado. Instalando..."
                sudo apt-get update
                sudo apt-get install bc -y
                echo "bc se ha instalado correctamente."
            else
                echo "bc ya está instalado."
            fi
        # Calcular porcentajes
            gc_percentage=$(echo "scale=2; ($gc_bases * 100) / $total_bases" | bc)
            at_percentage=$(echo "scale=2; ($at_bases * 100) / $total_bases" | bc)

        # Mostrar los resultados
            echo "Porcentaje de GC: $gc_percentage%"
            echo "Porcentaje de AT: $at_percentage%"
            echo "Longitud total de la secuencia: $total_bases bases"
        ;;
    3)
        ## Función adicional 03: Búsqueda de secuencias ATG en el archivo FastQ concatenado
        # Buscar secuencias ATG en el archivo FastQ
            echo " En estos headers se ha localizado un condon ATG, indicando una posibilidad de ser un codon de Inicio"
            grep -B 1 "ATG" "$archivo_concatenado.fastq" | grep "^@"
        ;;
    4)
        ## Función adicional 04: Identificar ORFS mediante la plataforma GETORF-EMBOSS
   
        # Verificar si EMBOSS está instalado
            if ! command -v getorf &> /dev/null; then
                 echo "EMBOSS no está instalado. Instalando..."
                sudo apt-get update
                sudo apt-get install emboss -y
            fi

        # Verificar la existencia del archivo FastQ
            archivo_fastq="$archivo_concatenado.fastq"

            if [ ! -f "$archivo_concatenado.fastq" ]; then
                echo "El archivo $archivo_concatenado.fastq no existe."
                exit 1
            fi

        # Ejecutar getorf para buscar ORFs
            getorf -sequence "$archivo_concatenado.fastq" -outseq $archivo_concatenado.orf

        # Verificar si se encontraron ORFs y mostrar resultados
            if [ -f "$archivo_concatenado.orf" ]; then
                echo "Se han encontrado ORFs. Los resultados se han guardado en $archivo_concatenado.orf"
            else
                echo "No se encontraron ORFs en $archivo_concatenado.fastq"
            fi   
        ;;
    *)
        echo "Opción no válida"
        exit 1
        ;;
    
esac