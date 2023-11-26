# Proyecto: Concatenación y análisis básicos de archivos FastQ

Este proyecto consiste en el desarrollo de una herramienta bioinformática para realizar la concatenación de archivos FastQ y análisis simples de datos genómicos. Este es un script que permite automatizar acciones básicas a realizar durante el procesamiento y análisis de archivos FastQ obtenidos de investigaciones genómicas, por lo cual resulta útil para su aplicación en flujos de trabajo de índole biológica. El desarrollo de este proyecto forma parte del trabajo final del curso de Principios de Programación Bioinformática de la carrera de Biología en la UPC.

## Características Principales
1. **Concatenación de archivos FastQ:**
   - Combina múltiples archivos FastQ en un solo archivo FastQ.

2. **Conversión a formato Fasta:**
   - Transforma el archivo concatenado FastQ a formato Fasta para facilitar su uso para análisis bioinformáticos posteriores.
   - Calcula estadísticas clave del archivo Fasta obtenido, como cantidad total de bases, contenido GC% y contenido AT%.

3. **Obtención de estadísticas del archivo concatenado FastQ**
    - Calcula estadísticas clave del archivo FastQ concatenado, como cantidad total de bases, contenido GC% y contenido AT%.

4. **Identificación de posibles ORFs**
    - Identifica posibles regiones codificantes en las secuencias del archivo FastQ concatenado empleando el programa EMBOSS.

## Prerequisitos

Para la ejecución eficiente del cálculo de estadísticas de las secuencias e identificación de ORFs, se recomienda instalar de antemano los siguientes comandos y programas:
- [Comando bc](http://ftp.gnu.org/gnu/bc/) instalado para cálculo de estadísticas de las secuencias.
- [Programa EMBOSS](ftp://emboss.open-bio.org/pub/EMBOSS/) instalado para la identificación de ORFs.
- [Bash](https://www.gnu.org/software/bash/) para la ejecución del script.

Ambos paquetes se pueden instalar utilizando el comando `sudo apt-get install`.

## Instalación

**A partir de un archivo**

1. Descarga el archivo `concatenar_fastq.sh`.
2. Navega al directorio donde se encuentren los datos del proyecto.
3. Ejecuta el script principal: `./concatenar_fastq.sh archivo1.fastq archivo2.fastq ...`
4. En caso de desear colocarlo como un comando habitual, realizar el siguiente comando:
	chmod +x ~/concatenar_fastq.sh --> Remplazar la ruta en la que se haya instalado el programa.
	sudo ln -s ~/concatenar_fastq.sh /usr/local/bin/
ó
	export PATH="$PATH:~" --> Esta opcion te permitira poder usar todos los scripts/ejecutables dentro de la carpeta home/user. Una vez reiniciada la terminal se borrara el PATH, procurar activarlo antes de empezar a trabajar. 

**Desde GitHub**

1. Clona el repositorio: `git clone https://github.com/upcalejandra/ConcatenarFastQ`
2. Navega al directorio del proyecto: `cd ConcatenarFastQ
3. Ejecuta el script principal: `./concatenar_fastq.sh archivo1.fastq archivo2.fastq ...`

## Contribuciones

Todas las contribuciones son bienvenidas, al igual que comentarios, sugerencias de mejora o problemas encontrados. Por favor, recordar que este proyecto forma parte de un trabajo de clase, por lo cual la implementación de mejoras no será supervisada por un docente capacitado.

## Autores

  - **Alejandra León** (https://github.com/upcalejandra)
  - **Sebastián Leyva** (https://github.com/vSpeed18)


## Reconocimientos

  - Agradecemos a los profesores Manuel y Frank del curso Principios de Programación Bioinformática, desde el cual se originó este proyecto.
