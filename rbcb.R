library(rbcb)
library(tidyr)
library(dplyr)
library(ggplot2)
inicio <- as.Date("2016-01-01")
fim <- as.Date("2016-12-01")

ipca16 <- get_series(code = 443,
                     start_date = inicio,
                     end_date = fim,
                     name = "ipca",
                     as = "tibble")

nr <- 11
nc <- 7
datas <- seq(as.Date("2017-01-01"), length.out = nr, by = "months")
df <- sapply(1:nc, FUN = rnorm, n = nrow(df))
df_datas <- cbind(datas, df)
colnames(df_datas) <- c("Data", paste("col", 1:nc, sep = "_"))
df_datas

ipca_por_grupos <- readRDS("ipca.rds")

ipca_plot <- ipca_por_grupos %>% 
  gather(key = grupo, value = variacao, -data) %>% 
  filter(grupo %in% c("ipca", "alimentacao", "habitacao", "transportes"))

plot <- ggplot(ipca_plot, aes(x = data, y = variacao))+
  geom_line(aes(color = grupo))+
  scale_colour_manual(values = c('green','red','yellow', 'black'))
plot

