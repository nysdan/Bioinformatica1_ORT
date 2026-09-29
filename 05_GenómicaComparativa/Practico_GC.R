setwd("/home/jovyan/Bioinformatica1_ORT-A/05_GenómicaComparativa/Bacterias")

# Cargamos biblioteca
library(seqinr)

# Para importar los genomas de la carpeta genome.seq

ecoli <-
bjapon <- 
crudd <-
pcellu <- 
pmarin <- 

# Creamos el data frame "gc_genomas", e inicializamos con 0
gc_genomas <- data.frame(Genoma = 0, GC = 0)

# Asigno el char "B.japonicum" a fila 1 columna 1 del data frame
gc_genomas[1,1] <- "B.japonicum"
gc_genomas[1,2] <- GC(unlist(bjapon))

gc_genomas[2,1] <-
gc_genomas[2,2] <-

gc_genomas[3,1] <-
gc_genomas[3,2] <-

gc_genomas[4,1] <-
gc_genomas[4,2] <-

gc_genomas[5,1] <-
gc_genomas[5,2] <-

# barplot con R "base"
barplot(height = , 
	names.arg = )


# Para importar los CDSs (genes)

cdsecoli <- 
cdsbjapon <-
cdscrudd <- 
cdspcellu <-
cdspmanin <-

# Contenido GC de las secuencias codificantes
GC.bjapon <-
GC.ecoli <- 
GC.crudd <- 
GC.pcellu <-
GC.pmarin <-

# Boxplot de contenido GC de cada gen, por cada organismo
boxplot(, 
        names = )


# -----------------------------------------------------------------------------

# GC por fragmentos
?getFrag

# Imprimo los nombres de los replicones



# Imprimo las longitudes de los replicones


# El replicon NC_002695.2 corresponde al cromosoma

getFrag(object = ecoli, begin = 10, end = 20)                  # --> devuelve list of char
getFrag(object = ecoli[["NC_002695.2"]], begin = 10, end = 20) # --> devuelve char 

# Extraigo el cromosoma y lo guardo en un objeto/variable
ecoli_ch1 

# Calculo GC% para fragmentos
GC_1 <- 
GC_2 <- 
# ...

data.frame(Posicion = c("1 a 10.000", "2.000.000 a 2.010.000"),
           GC = c(GC_1, GC_2))

# -----------------------------------------------------------------------------

# GC% por ventana deslizante (sliding window)

## Calcularemos el GC% para una ventana deslizante de largo 10K y step 10K
ln_ecoli_ch1 <- length(ecoli_ch1)
w_size <- 10000
step <- 10000

# Redondeo "hacia arriba"
?ceiling
ceiling(1.5)

wins <- data.frame(
  fragment_index = seq(1, ceiling(ln_ecoli_ch1/w_size)),
  from = seq(from = 1, to = ln_ecoli_ch1, by = w_size),
  to = c(seq(from = step, to = ln_ecoli_ch1, by = w_size), ln_ecoli_ch1) # Le agregamos la ultima pos
)

## MAPPLY
# A diferencia del lapply(), que itera sobre elementos individuales, mapply()
# itera sobre pares, triadas, etc, de elementos.

# mapply(
#   FUN       <- FUNCION 
#   ...       <- Argumentos de FUN sobre los que iterar, nombrados
#   MoreArgs  <- list() con otros argumentos que no iteran, tambien nombrados
# )

# Obtener fragmentos con mapply
ecoli_frags <- mapply(
  FUN = getFrag,                         # Funcion.
  begin = wins$from,                     # Paso columna "from" como vector a argumento "begin".
  end = wins$to,                         # Columna "to" como vector al argumento "end".
  MoreArgs = list(object = ecoli_ch1)    # Lista con argumento "object" ya que este no itera.
)

# Alternativa: for loop


# Calcular GC para cada fragmento
GCwin <- 

# Plot con R "base"
plot(x = wins$position, y = GCwin, type = "l")
abline(h = GC(ecoli[[1]]), col = "blue")
title(main = "GC por posicion", xlab = "Posicion", ylab = "GC")

# Con ggplot2
library(ggplot2)
wins$GCwin <- GCwin
ggplot(wins, mapping = aes(x = position, y = GCwin)) +
  geom_line() + 
  geom_hline(yintercept = GC(ecoli[[1]]), color = "blue")


# Sesgo en las composiciones nucleotídicas --------------------------------

?count
count(ecoli_ch1, wordsize = 1)
count(ecoli_ch1, wordsize = 1, freq = TRUE)

# Defino funcion para obtener conteos, dada la secuencia, la posicion de
# inicio, y la posicion de fin del fragmento.

getFragAndCount <- function(sq, from, to) {
  frag <- getFrag(object = sq, begin = from, end = to)
  conteo <- count(seq = frag, wordsize = 1)
  return(conteo)
}

NtComp <- mapply(
  FUN = getFragAndCount,           # Funcion que definimos arriba.
  from = wins$from, 
  to = wins$to, 
  MoreArgs = list(sq = ecoli_ch1), # <- sq es siempre la misma, no itera.
  SIMPLIFY = FALSE                 # <- FALSE evita que forme una matriz.
)

# | C/G -------------------------------------------------------------------

head(NtComp)
# Queremos extraer los valores de "g" y de "c" para cada elemento de la
# lista, los cuales son vectores de char de largo 4, con nombres.
?getElement # <- hace lo mismo que [[]]

# Aplicamos getElement dentro de funcion anonima para poder pasarle el
# parametro "name":

Gcount <- sapply(NtComp, function(x) { getElement(object = x, name = "g") })
Ccount <- sapply(NtComp, function(x) { getElement(object = x, name = "c") })

# Dividimos ambos vectores.
CdivG <- Ccount / Gcount

plot(x = wins$from, y = CdivG, type = "l")
# plot(x = wins$fragment_index, y = CdivG, type = "l")
abline(h = 1, col = "blue")
title(main = "C/G por posicion")


# C-G ---------------------------------------------------------------------


# GC skew -----------------------------------------------------------------


