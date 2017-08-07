df <- data.frame(num = rnorm(9, 0, 1))
df$sinal <- ifelse(df$num > 0, yes = "positivo", no = "negativo")
head(df)
