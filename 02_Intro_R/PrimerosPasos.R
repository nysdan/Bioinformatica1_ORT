# Primeros pasos en R -----------------------------------------------------

# Asignación de valor a una variable usando tres formas diferentes
objeto <- 10 # Utilizamos la flecha '<-' para asignar el valor 10 a la variable 'objeto'
objeto = 10  # También se puede usar '=' para asignar valor a la variable
10 -> objeto  # Otra forma de asignación, pero menos común

# Reasignación de valor a la variable objeto
objeto <- 20  # Cambiamos el valor de 'objeto' de 10 a 20

# Imprimir el valor de objeto
objeto  # Imprimimos el valor actual de 'objeto', que es 20

# Tipos de datos ----------------------------------------------------------

# Declaración de variables con diferentes tipos de datos
caracteres <- "Hola mundo"  # Creamos una variable 'caracteres' que almacena una cadena de texto
numericos <- 1e-5  # Creamos una variable 'numericos' que almacena un número en notación científica
vnum <- 1:3  # Creamos un vector 'vnum' que contiene una secuencia de números del 1 al 3
vnum1 <- c(1,2,3)  # Creamos otro vector 'vnum1' que contiene los mismos números de forma diferente

# Comparación de dos vectores
vnum == vnum1  # Comparamos los elementos de 'vnum' y 'vnum1' y obtenemos un vector lógico de igualdad

# Obtener la clase de las variables
class(vnum)  # Obtenemos la clase (tipo de dato) de 'vnum', que es "integer" (entero)
class(vnum1)  # Obtenemos la clase de 'vnum1', que también es "integer"

logicos <- c(TRUE, T, FALSE, F)  # Creamos un vector 'logicos' que contiene valores lógicos (verdadero y falso)


# Vectores ----------------------------------------------------------------

# Un vector es una estructura unidimensional que contiene elementos del mismo tipo.

vnum  # Este vector fue definido previamente y contiene los números 1, 2 y 3.
logicos  # Otro vector definido previamente que contiene valores lógicos (TRUE y FALSE).
vchar <- c("pato", "perro", "gato", "iguana", "gorrión", "pato")  # Creación de un vector de caracteres.

# Combinación de vectores
vector1 <- c(vchar, "topo")  # Concatenación de 'vchar' con la cadena "topo" al final.
vector2 <- c("topo", vchar)  # Concatenación de la cadena "topo" con 'vchar' al principio.

c(vchar, logicos)  # Combinación de 'vchar' y 'logicos' en un nuevo vector.
c(vchar, vnum)     # Combinación de 'vchar' y 'vnum'.
c(logicos, vnum)   # Combinación de 'logicos' y 'vnum'.

# Longitud de un vector
length(vector1)  # Calcula la longitud del vector 'vector1'.

# Operaciones numéricas en vectores
mean(vnum)       # Calcula la media de los elementos en 'vnum'.
vnum + vnum      # Suma de vectores 'vnum' con sí mismos.
vnum %% 2        # Módulo 2 para cada elemento de 'vnum'.
2 %% 2           # Módulo 2 de 2.
3 %/% 2          # División entera de 3 por 2.
3**2             # Elevación de 3 al cuadrado.
3^2              # Otra forma de elevar 3 al cuadrado.

# Funciones matemáticas en vectores
sqrt(4)          # Raíz cuadrada de 4.
median(vnum)     # Mediana de 'vnum'.
sd(vnum)         # Desviación estándar de 'vnum'.

# Operadores lógicos
!vnum > 1         # Negación lógica de 'vnum' mayor que 1.
!F               # Negación lógica de FALSE (se convierte en TRUE).
!T               # Negación lógica de TRUE (se convierte en FALSE).

# Funciones matemáticas avanzadas
exp(10)          # Exponencial de 10.
log(10, base = 10)  # Logaritmo base 10 de 10.
round(pi, digits = 0)  # Redondea pi a 0 decimales.

# Vectores predefinidos
letters          # Vector de letras minúsculas.
LETTERS          # Vector de letras mayúsculas.
month.name       # Nombres de los meses en inglés.

# Indexación de vectores
letras <- letters  # Asignamos el vector de letras minúsculas a 'letras'.
letras[1]         # Accedemos al primer elemento de 'letras'.
letras[1:3]       # Accedemos a los tres primeros elementos de 'letras'.
letras[17]        # Accedemos al elemento en la posición 17 de 'letras'.
letras[-17]       # Eliminamos el elemento en la posición 17 de 'letras'.
letras[c(1:3,10:13)]  # Accedemos a elementos específicos de 'letras' usando índices.

indice <- c(1,4,18)  # Creamos un vector 'indice' con índices.
letras[indice]     # Accedemos a los elementos de 'letras' usando 'indice'.


# Matrices ----------------------------------------------------------------

# | Crear matrices a partir de un vector y nrow o ncol --------------------

vec1 <- 1:10  # Creamos un vector 'vec1' con números del 1 al 10.
M1 <- matrix(data = vec1, nrow = 2)  # Creamos una matriz 'M1' a partir de 'vec1' con 2 filas.

matrix(data = vec1, ncol = 5)  # Creamos una matriz con 5 columnas a partir de 'vec1'.

M2 <- matrix(data = vec1, nrow = 2, byrow = TRUE)  # Creamos 'M2' con 2 filas y llenamos por fila.

dim(M1)  # Obtener dimensiones de 'M1' (2 filas y 5 columnas).

dim(t(M1))  # Transponemos 'M1' y obtenemos sus nuevas dimensiones (5 filas y 2 columnas).

ncol(M1)  # Obtener el número de columnas de 'M1' (5).
nrow(M1)  # Obtener el número de filas de 'M1' (2).

# | Crear una matriz asignando dos dimensiones a un vector ----------------

vec1  # Vector original 'vec1'.
dim(vec1) <- c(5, 2)  # Asignamos dimensiones a 'vec1' (5 filas y 2 columnas).
dim(vec1)  # Verificamos las nuevas dimensiones de 'vec1'.

# | Crear una matriz a partir de dos o más vectores unidos ----------------

vec2 <- c(1, 3, 5, 7)
vec3 <- c(10, 30, 50, 70)

cbind(vec2, vec3)  # Creamos una matriz combinando 'vec2' y 'vec3' por columnas.
rbind(vec2, vec3)  # Creamos una matriz combinando 'vec2' y 'vec3' por filas.

cbind(vec3, vec2)  # Cambiamos el orden y creamos otra matriz combinando por columnas.

vec4 <- 1:2
vec5 <- 1:8

cbind(vec5, vec4)  # Combinamos 'vec5' y 'vec4' en una matriz de 8 filas y 2 columnas.

matrix(vec2, nrow = 5)  # Creamos una matriz de una columna a partir de 'vec2' con 5 filas.

# Funciones aplicables a matrices -----------------------------------------

M1 * 2  # Multiplicamos todos los elementos de 'M1' por 2.

colSums(M1)  # Suma las columnas de 'M1'.
M1  # Mostramos 'M1' nuevamente.

rowSums(M1)  # Suma las filas de 'M1'.

colMeans(M1)  # Calcula el promedio de cada columna en 'M1'.
rowMeans(M1)  # Calcula el promedio de cada fila en 'M1'.

M1
colnames(M1) <- c("col1", "col2", "col3", "col4", "col5")  # Asignamos nombres a las columnas.
rownames(M1) <- c("row1", "row2")  # Asignamos nombres a las filas.
rownames(M1)
         

# Data frames -------------------------------------------------------------

#   - Un data frame es una estructura de datos en R que se utiliza para almacenar datos tabulares
#   en forma de filas y columnas. Cada columna puede contener diferentes tipos de datos, como números,
#   caracteres o factores.
#   - Columnas: Las columnas de un data frame representan variables individuales o características de los datos.
#   Cada columna puede tener un nombre y contiene valores de un tipo de dato específico.
#   - Subsetting (Subconjuntos): Subsetting se refiere a la selección de partes específicas de un objeto, como
#   un data frame. Puedes subsetear un data frame para extraer filas o columnas específicas con base en
#   condiciones o índices.


# Creación de un archivo de texto para la tabla
# Puedes crear el archivo de texto en RStudio de la siguiente manera:
# 1. Haz clic en "File" en la parte superior del panel de RStudio.
# 2. Selecciona "New File" y luego "Text File" para crear un nuevo archivo de texto.
# 3. Copia y pega los siguientes datos en el archivo de texto (eliminar los comentarios '#'):
#
# Nombres Edades  Obs
# A 10  F
# B 11  F
# C 15  M
# D 18  M
# E 22  F
#
# 4. Guarda el archivo de texto con un nombre como "datos_tabla.txt" en tu directorio de trabajo.

# Ahora, puedes crear un data frame a partir de este archivo de texto.

# Lectura de un archivo de tabla
DF3 <- read.table(file = "datos_tabla.txt", header = TRUE)

# Aquí, "datos_tabla.txt" es el nombre del archivo de texto que creaste previamente.
# La opción "header = TRUE" indica que la primera fila contiene los nombres de las columnas.

# Estructura de un data frame
str(DF3)

# Acceso a columnas de un data frame
# Puedes acceder a las columnas de un data frame utilizando el operador '$' o '[,]'.
# Ejemplos:

DF3$Nombres     # Acceso a la columna "Nombres"
DF3$Edades      # Acceso a la columna "Edades"
DF3$Obs         # Acceso a la columna "Obs"

# También puedes utilizar la notación de índice para acceder a columnas.
# Por ejemplo, DF3[, 1] accede a la primera columna (Nombres).

# Definiciones de tipos de objetos:

# - Data Frame: Un data frame es una estructura de datos en R que se utiliza para almacenar datos tabulares
#   en forma de filas y columnas. Cada columna puede contener diferentes tipos de datos, como números,
#   caracteres o factores.

# - Columnas: Las columnas de un data frame representan variables individuales o características de los datos.
#   Cada columna puede tener un nombre y contiene valores de un tipo de dato específico.

# - Subsetting (Subconjuntos): Subsetting se refiere a la selección de partes específicas de un objeto, como
#   un data frame. Puedes subsetear un data frame para extraer filas o columnas específicas con base en
#   condiciones o índices.

# Ejemplos de subsetting:

# Subsetting de filas basado en una condición
DF3[DF3$Edades > 15, ]

# Subsetting de columnas por nombre
DF3$Nombres

# Subsetting de columnas por índice
DF3[, 2]

# Subsetting de múltiples columnas
DF3[, c("Nombres", "Edades")]


# Data frames -------------------------------------------------------------

# Creación de un vector
vec6 <- letters[1:4]  # Creamos un vector 'vec6' con las primeras 4 letras minúsculas.

# Creación de un data frame a partir de dos vectores
DF1 <- data.frame(vec2, vec3)  # Creamos un data frame 'DF1' con 'vec2' y 'vec3' como columnas.
colnames(DF1)  # Obtenemos los nombres de las columnas de 'DF1'.
rownames(DF1)  # Obtenemos los nombres de las filas de 'DF1'.

# Creación de vectores para unir en un data frame
nombres <- c("Paola", "Pablo", "Laura", "Camilo")
edades <- c(30, 18, 24, 28)

cbind(nombres, edades)  # Combinamos 'nombres' y 'edades' en una matriz.

# Creación de un data frame a partir de dos vectores
DF2 <- data.frame(nombres, edades)  # Creamos un data frame 'DF2' con 'nombres' y 'edades'.
str(DF2)  # Mostramos la estructura de 'DF2'.

DF2[, 1]  # Accedemos a la primera columna de 'DF2'.

# Convertir una matriz en un data frame
as.data.frame(M1)  # Convertimos 'M1' en un data frame.

# Leer un archivo de tabla con o sin encabezados

read.table(file = "ejemplotabla.tsv", header = TRUE)  # Leemos el archivo con encabezados.

# Diferencias con y sin header = T
# El archivo ejemplotabla.tsv debe tener encabezados para que header = TRUE funcione correctamente.

# Leer un archivo de tabla con decimales en formato "," en lugar de "."
DF3 <- read.table(file = "ejemplotabla.tsv", header = TRUE)  # Leemos el archivo con encabezados.
DF4 <- read.table(file = "ejemplotabla.tsv", header = TRUE, dec = ",")  # Leemos el archivo con ',' como decimal.


# Listas ------------------------------------------------------------------

lista1 <- list(vec2, M1, DF3, "a")  # Creamos una lista llamada 'lista1' que contiene varios elementos diferentes.
length(lista1)  # Obtenemos la longitud de la lista (número de elementos).

str(lista1)  # Mostramos la estructura de 'lista1', incluyendo los tipos de datos de sus elementos.

names(lista1) <- c("e1", "e2", "e3", "e4")  # Asignamos nombres a los elementos de 'lista1'.
lista1[[1]]  # Accedemos al primer elemento de 'lista1'.
lista1[[3]]  # Accedemos al tercer elemento de 'lista1'.

lista1$e1  # Accedemos al elemento de 'lista1' con el nombre 'e1'.
lista1$e2  # Accedemos al elemento de 'lista1' con el nombre 'e2'.

names(lista1)  # Mostramos los nombres de los elementos de 'lista1'.

DF2$edades  # Accedemos a la columna 'edades' del data frame 'DF2'.
