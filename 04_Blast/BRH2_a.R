
# Objetivo de esta lección en R: Cargar secuencias de genes, traducirlas a 
# aminoácidos, y escribirlas en archivos. Largar blastp all vs all, cargar 
# las tablas, manipularlas para obtener los BRH. Además vamos a repasar algunas
# funciones y algoritmos básicos de R, y vamos a ver algunos paquetes útiles e
# intuitivos para la manipulación de tablas.

# Comenzar discutiendo cómo mejorar el BRH de la clase anterior, el cual se hizo
# utilizando secuencias nucleotídicas. 

# En TERMINAL: Creamos directorio y copiamos los mismos archivos que la clase
# pasada:
# cd ~/Bioinformatica1_ORT/04_Blast/
# mkdir BRH_prot
# cp BRH/NC_016831_salmonella.ffn BRH/NC_017631_ecoli.ffn BRH_prot/
# cd BRH_prot/

# Seteamos el directorio de trabajo
setwd("~/Bioinformatica1_ORT/04_Blast/BRH_prot/")


# Cargamos biblioteca seqinr
library(seqinr)

# Leemos archivos fasta (ffn) con genes.


# Qué clase de objetos son?

# Qué nombres tienen?

# Cuántas secuencias hay?

# Cuál es el largo de cada una de las secuencias?

# ...





# Si quisiéramos imprimir en la consola todos los largos en pantalla

#loop for


# Si queremos guardar los largos en un vector:
# Creamos un vector vacío de largo length(ecoli_genes)
vec_lengths <- vector(mode = "integer", length = length(ecoli_genes))
# Iteramos y vamos guardando los largos
for (i in seq_along(ecoli_genes)){
	vec_lengths[i] <- length(ecoli_genes[[i]])
}
head(vec_lengths, n = 10)

# Otra forma equivalente
# con sapply

# ¿Los resultados son iguales?


# 

# ¿En qué se diferencian?

# Contenido GC de las secuencias ------------------------------------------
GC(ecoli_genes)
# ¿Por qué da error?



# Traducción --------------------------------------------------------------
ecoli_prot <- lapply(ecoli_genes, translate)
head(ecoli_prot)

# Exportar el fasta -------------------------------------------------------

# Escribimos un fasta (usaremos la extensión .faa como convensión para indicar
# que es un archivo con las secuencias aminoacídicas)
?write.fasta
write.fasta(
	sequences = ecoli_prot, 
	names = names(ecoli_prot),
	file.out = "./NC_017631_ecoli.faa"
)

################################### TERMINAL ##################################

# Ir a una terminal y chequear el archivo que escribimos


###################################### R ######################################

# Repetir el proceso de lectura, traducción y escritura para el ffn de
# Salmonella









################################### TERMINAL ##################################

# Construir bases de datos de blast y ejecutar blastp
## Los siguientes comandos deben ser ejecutados en la terminal. Prestar atención
## al directorio de trabajo. Utilizar (en la terminal! No en R) pwd, ls, y
## ayudarse del [TAB] para chequear los archivos existan y estén bien escritos.

# makeblastdb ...


# Ejecutar Blastp (demora algunos segundos) utilizando la matríz de sustitución BLOSUM45, -subject_besthit, y las columnas qseqid sseqid pident evalue length gaps qcovs


###############################################################################


# Leemos ambas tablas como data.frame
blastp_eco_vs_sal <- read.table("ecoli_vs_salmonella_blastp.tab", sep = "\t", stringsAsFactors = F)
blastp_sal_vs_eco <- read.table("salmonella_vs_ecoli_blastp.tab", sep = "\t", stringsAsFactors = F)

head(blastp_eco_vs_sal)

# Como blast no devuelve las columnas con nombre, se los agregamos
cols <- # crear un vector con los mombres de las columnas y cambiar los nombres de columna
 

head(blastp_eco_vs_sal)

# Filtrado de tablas utilizando dplyr (y magrittr)

## magrittr: provee el operador %>% para hacer "pipe" en R.
## Ejemplo:
class(nrow(blastp_eco_vs_sal))

library(magrittr)
blastp_eco_vs_sal %>% nrow() %>% class()
# Por default, el primer parámetro es el que acepta la entrada.
# Si queremos pasar la entrada a otro parámetro, lo señalamos con .
# El ejemplo que sigue es equivalente, excepto que indicamos los 
# parámetros que queremos que acepten la entrada. Si vemos la ayuda
# de nrow y class, vemos que en ambos casos los parámetros se llaman "x".

blastp_eco_vs_sal %>% nrow(x = .) %>% class(x = .)

## dplyr: Provee de verbos para la manipulación de tablas.
# https://dplyr.tidyverse.org/


library(dplyr)

# Filtramos por evalue <= 1e-20, piden >= 40, y qcovs >= 70
blastp_eco_vs_sal_filt <- blastp_eco_vs_sal 

	

# Cuántas filas se filtraron?

blastp_sal_vs_eco_filt <- blastp_sal_vs_eco 

# Cuántas filas se filtraron?

# Identificamos mejores hits recíprocos

## Nos quedamos con las columnas qseqid y sseqid utilizando el verbo select() (dplyr).
## Además eliminamos filas repetidas para evitar aquellos subjects que tienen más 
## de un hit (posiblemente dominios) con unique(). 

blastp_eco_vs_sal_filt_names <- blastp_eco_vs_sal_filt %>%
	select(qseqid, sseqid) %>%    # selecciona las columnas qseqid y sseqid.
	unique()                      # colapsa filas repetidas.

ncol(blastp_eco_vs_sal_filt)
ncol(blastp_eco_vs_sal_filt_names)

#¿Cuantas filas se filtraron?
# Igual pero cambiamos nombres de columnas para que al unir ambos data.frames (más 
# abajo) se den vuelta. rbind() es sensible a los nombres de las columnas, 
# por lo que al unir ambos data.frames va a tener el mismo efecto que dar
# vuelta con awk en la clase pasada.
blastp_sal_vs_eco_filt_names <- blastp_sal_vs_eco_filt %>%
	select(qseqid, sseqid) %>%
	rename(
		qseqid = sseqid, # Renombra sseqid como qseqid.
		sseqid = qseqid  # Renombra qseqid como sseqid.
	) %>%
	unique()

# Pegamos ambos df con rbind(), creamos una nueva columna llamada "pasted" con
# mutate() y paste() que contiene los strings de ambas columnas pegados. Posteriormente
# utiliza pull() (dplyr) para extraer una columna devolviendo un vector. Por ultimo hace
# dos conteos. Primero cuenta cuántas veces aparece cada vector de caracteres, y después
# cuenta cuántas veces aparece "1" y "2".
rbind(                                          # Une data.frames.
	blastp_eco_vs_sal_filt_names, 
	blastp_sal_vs_eco_filt_names
) %>% 
	mutate(pasted = paste(qseqid, sseqid)) %>%    # Crea la columna "pasted" pegando qseqid y sseqid.
	pull(pasted) %>%                              # Extrae esta última columna como un vector del tipo "character" (strings).
	table() %>%                                   # Cuenta las veces que aparece cada columna.
	table()                                       # Cuenta las veces que hay 1 y 2.


# Cómo varía con respecto al ejemplo de la clase anterior?

