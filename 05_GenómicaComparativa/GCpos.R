setwd("/home/jovyan/Bioinformatica1_ORT/05_GenómicaComparativa/Bacterias/")

library(seqinr)

pmarinus <- read.fasta("genome.seq/Pmarinus.fna")
ecoli <- read.fasta("genome.seq/Ecoli.fna") 
bjaponicum <- read.fasta("genome.seq/Bjaponicum.fna")

GC(unlist(pmarinus))
GC(unlist(ecoli))
GC(unlist(bjaponicum))


CDSpmarinus <- read.fasta("cds/Pmarinus.ffn") 
CDSecoli <- read.fasta("cds/Ecoli.ffn") 
CDSbjaponicum <- read.fasta("cds/Bjaponicum.ffn") 

GCpmarinus <- sapply(CDSpmarinus,GC)
GCecoli <- sapply(CDSecoli,GC)
GCbjaponicum <- sapply(CDSbjaponicum,GC)

S <- ecoli[[1]]
S1 <- ecoli[1]

gc <- GC(S)

S1_1 <- getFrag(object = S1, begin = 1, end = 10000)
GC_1 <- GC(S1_1[[1]])
S1_2 <- getFrag(object = S1, begin = 2000000, end = 2010000)
GC_2 <- GC(S1_2[[1]])
S1_3 <- getFrag(object = S1, begin = 3000000, end = 3010000)
GC_3 <- GC(S1_3[[1]])
S1_4 <- getFrag(object = S1, begin = 4000000, end = 4001000)
GC_4 <- GC(S1_4[[1]])

data.frame(Secuencia=c("S1_1", "S1_2", "S1_3", "S1_4", "S1"),
           Posicion=c("1 a 10.000", "2.000.000 a 2.010.000",
                      "3.000.000 a 3.010.000", "4.000.000 a 4.010.000", "Total"),
           GC=c(GC_1, GC_2, GC_3, GC_4, gc))

length(S1[[1]])/10000

lista <- list()

for (i in 1:550){
  lista[[i]] <- c(rep(i,10000))
}


FAC <- as.factor(unlist(lista))

length(FAC)
FAC <- FAC[-c((length(S1[[1]])+1):5500000)]
length(FAC)

sp <- split(x = ecoli[[1]], f = FAC, drop = FALSE)
length(sp)
lengths(sp)

sp[[2]][1:10]
sp[[1]][1:100]

GCwin <- c()

for(i in 1:550){
  GCwin[[i]] <- GC(sp[[i]])
}

sapply(sp, GC)

pos <- seq.default(from = 1, to = length(FAC), by = 10000)

plot(x = pos, y = GCwin, type = "l")

abline(h = GC(ecoli[[1]]), col = "blue")
title(main = "GC por posicion", xlab = "Posicion", ylab = "GC")

