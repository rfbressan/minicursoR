library(rbcb)
library(tidyr)
library(dplyr)
library(ggplot2)
inicio <- as.Date("2016-01-01")
fim <- as.Date("2016-12-01")
<<<<<<< HEAD
# ipca16 <- get_series(code = 443,
#                      start_date = inicio,
#                      end_date = fim,
#                      name = "ipca", 
#                      as = "tibble")
=======
ipca16 <- get_series(code = 443,
                     start_date = inicio,
                     end_date = fim,
                     name = "ipca",
                     as = "tibble")
>>>>>>> 4dc61fb0782cba6c704949f23bcbd1a804849b43
nr <- 11
nc <- 7
datas <- seq(as.Date("2017-01-01"), length.out = nr, by = "months")
df <- sapply(1:nc, FUN = rnorm, n = nrow(df))
df_datas <- cbind(datas, df)
colnames(df_datas) <- c("Data", paste("col", 1:nc, sep = "_"))
df_datas

<<<<<<< HEAD
ipca_por_grupos <- readRDS("ipca.rds")

ipca_plot <- ipca_por_grupos %>% 
  gather(key = grupo, value = variacao, -data) %>% 
  filter(grupo %in% c("ipca", "alimentacao", "habitacao", "transportes"))

plot <- ggplot(ipca_plot, aes(x = data, y = variacao))+
  geom_line(aes(color = grupo))
plot
=======
## Salvar em um arquivo RDS e ler depois ##################################################################
# saveRDS(object, file = "", ascii = FALSE, version = NULL,
#         compress = TRUE, refhook = NULL)
# 
# readRDS(file, refhook = NULL)
>>>>>>> 4dc61fb0782cba6c704949f23bcbd1a804849b43
