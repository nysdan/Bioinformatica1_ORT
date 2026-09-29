
# Largos de los genomas ---------------------------------------------------


#  | Seteo el directorio de trabajo ---------------------------------------

# ~/Bioinformatica1_ORT/05_GenómicaComparativa/Bacterias

setwd("/home/jovyan/Bioinformatica1_ORT/05_GenómicaComparativa/Bacterias")

#  | Importar las secuencias genómicas a R --------------------------------

library(seqinr)

ecoli <- read.fasta("genome.seq/Ecoli.fna")
pmarinus <- read.fasta("genome.seq/Pmarinus.fna")
pcellulosum <- read.fasta("genome.seq/Pcellulosum.fna")
crudii <- read.fasta("genome.seq/C.ruddii.fna")
bjaponicum <- read.fasta("genome.seq/Bjaponicum.fna")



# | Obtener los largos de los genomas -------------------------------------


length(ecoli)
length(unlist(ecoli))

ln_pm <- length(unlist(pmarinus))
ln_pc <- length(unlist(pcellulosum))
ln_ec <- length(unlist(ecoli))
ln_bj <- length(unlist(bjaponicum))
ln_cr <- length(unlist(crudii))


# | Crear un data frame ---------------------------------------------------


largos <- data.frame(Especie = c("P. marinus", "P. cellulosum", "E. coli", "B. japonicum", "C. rudii"),
                     Largo = c(ln_pm, ln_pc, ln_ec, ln_bj, ln_cr))
?barplot


#  | Gráfico de barras ----------------------------------------------------


#  |  |  R Base -----------------------------------------------------------


barplot(height = largos$largos, names.arg = largos$Bacteria)


#  |  | GGPlot ------------------------------------------------------------

library(ggplot2)

ggplot(data = largos, mapping = aes(x = Especie, y = Largo)) +
  geom_col()
