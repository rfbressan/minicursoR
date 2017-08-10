##  Aula 3 - Econometria
library(tidyverse)

dados <- tibble(x_2 = rnorm(100, 50, 11),
                x_3 = rnorm(100, 10, 1), 
                y = 10 + 0.75*x_2 - 0.4*x_3 + rnorm(100))

reg <- lm(y ~ x_2 + x_3, data = dados)
class(reg)
str(reg)
coef(reg)
sumario_reg <- summary(reg)
sumario_reg$coefficients
sumario_reg$coefficients[1, ,drop = FALSE]
sumario_reg$r.squared

# Dados de Corrupcao etc --------------------------------------------------
democracy <- as.tibble(read.csv2(file = "democracy_index.csv", dec = ".", stringsAsFactors = FALSE))
corruption <- as.tibble(read.csv2(file = "corruption_index.csv", dec = ".", stringsAsFactors = FALSE))
human <- as.tibble(read.csv2(file = "human_development_index.csv", dec = ".", stringsAsFactors = FALSE))
press <- as.tibble(read.csv2(file = "press_freedom.csv", dec = ".", stringsAsFactors = FALSE))

# Ajusta observacoes com NA e nomes de colunas ----------------------------
democracy  <- democracy[complete.cases(democracy), ]
colnames(democracy) <- c("Country", 2006, 2008, 2010:2016)

corruption <- corruption[complete.cases(corruption), ]
colnames(corruption) <- c("Country", 2006:2016)

human <- human[complete.cases(human), ]
colnames(human) <- c("Country", 2006:2015)

press <- press[complete.cases(press), ]
colnames(press) <- c("Country", 2006:2017)

# Transforma em Tidy ------------------------------------------------------
democracy_tidy <- democracy %>% 
  gather(key = Ano, value = Valor, -Country)

corruption_tidy <- corruption %>% 
  gather(key = Ano, value = Valor, -Country)

human_tidy <- human %>% 
  gather(key = Ano, value = Valor, -Country)

press_tidy <- press %>% 
  gather(key = Ano, value = Valor, -Country)

# Junta todos os data frames ----------------------------------------------
big_data <- democracy_tidy %>% 
  inner_join(corruption_tidy, by = c("Country", "Ano")) %>% 
  inner_join(human_tidy, by = c("Country", "Ano")) %>% 
  inner_join(press_tidy, by = c("Country", "Ano"))
colnames(big_data) <- c("Country", "Ano", "Democracia", "Corrupcao", "IDH", "Imprensa")


# Filtra ultimo ano -------------------------------------------------------
a2015 <- big_data %>% 
  filter(Ano == max(Ano))

# Regressao Linear Corrupcao ~ restante -----------------------------------
reg <- lm(Corrupcao ~ Democracia + IDH + Imprensa, data = a2015)
summary(reg)

# Funcao by() -------------------------------------------------------------
f_aux <- function(df) {
  reg <- lm(Corrupcao ~ Democracia + IDH + Imprensa, data = df)
}

# Funcao by() combina o split e lapply em uma soh
por_ano <- by(big_data, big_data$Ano, f_aux)
summary(por_ano$`2012`)
# enframe cria um tibble com uma coluna sendo os nomes dos elementos da lista
# e a outra coluna o conteudo. No caso os objetos da classe lm
tbl_por_ano <- enframe(por_ano)
