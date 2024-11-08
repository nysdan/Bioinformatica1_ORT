
#####################################################################
# PCA: Análisis de componentes principales. Para datos cuantitativos.
#####################################################################

# Datos: iris
head(iris) 
# Qué 

iris_data <- iris[, 1:4]

# Paso 1: Escalar los datos
# El PCA requiere que los datos estén escalados para que todas las variables tengan la misma influencia
iris_scaled <- scale(iris_data)

# Paso 2: Realizar el PCA
# Utilizamos la función prcomp para realizar el análisis de componentes principales
pca_result <- prcomp(iris_scaled)

# Inspeccionar los resultados del PCA
summary(pca_result) # Muestra la varianza explicada por cada componente
pca_result$rotation # Muestra los eigenvectores (direcciones de los componentes)

# Paso 3: Graficar los componentes principales
# Visualizar los dos primeros componentes principales
# Usamos el color para diferenciar las especies de iris
library(ggplot2)
pca_data <- as.data.frame(pca_result$x)
pca_data$Species <- iris$Species

ggplot(pca_data, aes(x = PC1, y = PC2, color = Species)) +
  geom_point(size = 2) +
  labs(title = "PCA de Iris: PC1 vs PC2", x = "Componente Principal 1", y = "Componente Principal 2") 
# Paso 4: Interpretación
# Ver la proporción de varianza explicada por cada componente 
eigenvalues <- pca_result$sdev ^ 2
varianza_explicada <- eigenvalues / sum(eigenvalues)
varianza_explicada

# Visualizar la varianza explicada acumulada
plot(cumsum(varianza_explicada), type = "l", xlab = "Número de Componentes",
     ylab = "Varianza Explicada Acumulada", main = "Varianza Explicada por Componentes Principales")


# Cuánto contribuye cada variable a la varianza observada en cada PC?
cargas <- t(pca_result$rotation)
# Contribución de cada variable a la varianza de cada componente:
contribuciones_por_componentes <- cargas^2
contribuciones_por_componentes
colSums(contribuciones_por_componentes) # 1

# Contribución de cada variable a la varianza total explicada:
contribuciones_totales <- t(t(contribuciones_por_componentes) * varianza_explicada)
colSums(contribuciones_totales)

sum(colSums(contribuciones_totales)) # 1




###############################################################################
# Análisis de correspondencias (con ade4): Para datos de conteos (cualitativos)
###############################################################################
library(ade4)

# FactoMineR: Sólo lo cargamos porque contiene un dataset de ejemplo para la clase.
library(FactoMineR) 


# Se carga el dataset "tea" del paquete FactoMineR
data(tea)
# El dataset contiene información sobre las preferencias de té según diferentes
# características demográficas. Vamos a enfocarnos en una tabla de contingencia 
# para ilustrar el análisis de correspondencias.

dim(tea)
colnames(tea)

# Tabla de contingencia con conteos de preferencias de Te según categoría de edad.
tabla_contingencia <- table(tea$age_Q, tea$Tea)
class(tabla_contingencia)

# Transformo de "table" a "matrix" (necesario luego), y sobreescribo objeto:
tabla_contingencia <- unclass(tabla_contingencia)

# Utilizo la función ade4::dudi.coa() ("dudi": duality diagrams)
# scannf = FALSE --> para que no plotee, ni sea interactivo.
# nf = 2 --> número de dimensiones (componentes) con los que me quedo.
coa_results <- dudi.coa(tabla_contingencia, scannf = FALSE, nf = 2)

# Coordenadas de las filas (edades) en el espacio de correspondencias
coa_results$li

# Coordenadas de las columnas (Tipo de té) en el espacio de correspondencias
coa_results$co

#' Estas coordenadas indican la posición de cada categoría en el espacio 
#' reducido del análisis de correspondencias, permitiendo ver relaciones 
#' o proximidades entre las categorías.

# Eigenvalues:
coa_results$eig

# • coa_results$nf indica cuantos ejes se conservaron
# • coa_results$cw es un vector numérico que contiene los pesos de las columnas
# • coa_results$lw es un vector numérico que contiene los pesos de las filas
# • coa_results$eig es un vector numérico que contiene los eigenvalues (valores propios)
# • coa_results$tab es un data frame que contiene la matriz de entrada
# • coa_results$li es un data frame que contiene las coordenadas de las filas en los 2 ejes que se
#   conservaron
# • coa_results$co es un data frame que contiene las coordenadas de las columnas en los 2 ejes que se
#   conservaron
# • coa_results$l1 es un data frame que contiene los componentes principales
# • coa_results$c1 es un data frame que contiene los ejes principales


# Plot de edades
plot(coa_results$li[, 1], coa_results$li[, 2])
# Plot de preferencias de tipos de té
plot(coa_results$co[, 1], coa_results$co[, 2])

#' Proximidad: En el gráfico, las categorías que están cercanas entre sí 
#' están asociadas. Por ejemplo, si una categoría de edad está cerca de 
#' una preferencia de té, esto indica que esa preferencia es común en ese 
#' grupo de edad.
#' Ejes: Los ejes representan las dimensiones que explican la mayor parte 
#' de la inercia (variabilidad) en los datos. En un análisis de correspondencias, 
#' estos ejes se interpretan de forma similar a los componentes principales en 
#' PCA.


# Análisis de correspondencias ponderado (Weighted): WCA

#' Extensión del análisis de correspondencias (CA) estándar. Esta técnica 
#' permite investigar cómo una variable de clasificación adicional afecta 
#' la relación entre las variables en una tabla de contingencia.

#' wca es útil cuando:
#' I) Hay una variable suplementaria de clasificación: Por ejemplo, si tenés 
#' datos categóricos organizados en una tabla de contingencia y querés analizar 
#' las relaciones en las filas o columnas, pero teniendo en cuenta una variable 
#' adicional que clasifica esas filas o columnas (como un grupo demográfico, una 
#' región, etc.).
#' II) Necesitas eliminar el efecto de una variable de agrupación: Si una variable 
#' de agrupación afecta mucho las relaciones en los datos, podés usar WCA para 
#' estudiar las relaciones restantes una vez que se "elimina" ese efecto.
#' III) Querés analizar las relaciones entre variables dentro de subgrupos: Por 
#' ejemplo, en un análisis de preferencias de productos según edad, podrías querer 
#' ver cómo cambian las preferencias si se separan los datos por género o por región.

# Agregamos otra variable suplementaria
# Nacieron después de los 90s?
rownames(tabla_contingencia)
nineties_kids <- factor(c("Si", "Si", "No", "No", "No"))

wca_resultado <- wca(coa_results, fac = nineties_kids, scannf = FALSE)
wca_resultado

xmax <- max(wca_resultado$li[,1])
xmin <- min(wca_resultado$li[,1])
ymax <- max(wca_resultado$li[,2])
ymin <- min(wca_resultado$li[,2])

plot(
  x = wca_resultado$li[nineties_kids == "Si", 1], 
  y = wca_resultado$li[nineties_kids == "Si", 2],
  pch = 20, col = "orange",
  xlab="Axis 1",ylab="Axis 2",
  xlim=c(xmin,xmax),ylim=c(ymin,ymax) 
)

plot(
  x = wca_resultado$li[nineties_kids == "No", 1], 
  y = wca_resultado$li[nineties_kids == "No", 2],
  pch = 20, col = "cyan",
  xlab="Axis 1",ylab="Axis 2",
  xlim=c(xmin,xmax),ylim=c(ymin,ymax) 
)

# Ploteo de ambos gráficos

plot(
  x = wca_resultado$li[nineties_kids == "Si", 1], 
  y = wca_resultado$li[nineties_kids == "Si", 2],
  pch = 20, col = "orange",
  xlab="Axis 1",ylab="Axis 2",
  xlim=c(xmin,xmax),ylim=c(ymin,ymax) 
)
par(new = TRUE)
plot(
  x = wca_resultado$li[nineties_kids == "No", 1], 
  y = wca_resultado$li[nineties_kids == "No", 2],
  pch = 20, col = "cyan",
  xlab="Axis 1",ylab="Axis 2",
  xlim=c(xmin,xmax),ylim=c(ymin,ymax) 
)
s.label(
  wca_resultado$co, 
  add.plot = TRUE, 
  clab = 0.75, 
  boxes = FALSE,
  xlim=c(xmin,xmax), 
  ylim=c(ymin, ymax)
)
abline(v=0,h=0,lty="dotted")


