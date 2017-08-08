library(rbcb)
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
df <- sapply(1:nc, 2, FUN = rnorm, n = nrow(df))
df_datas <- cbind(datas, df)
colnames(df_datas) <- c("Data", paste("col", 1:nc, sep = "_"))
df_datas
