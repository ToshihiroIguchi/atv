#Analysis of two variables

library(ggplot2)

#x, yを入力すると、数値か項目か判断して評価可能な検定をすべて行う。
atv <- function(x, y){
  
  result <- list(cor = NULL, aov = NULL, con = NULL, 
                 xy = data.frame(x = x, y = y),
                 method = NULL)
  class(result) <- "atv"
  
  #数値vs数値
  #回帰分析
  if(is.numeric(x) && is.numeric(y)){
    result$cor$kendall <- cor.test(x = x, y = y, alternative = "two.sided",
                                   method = "kendall")
    result$cor$spearman <- cor.test(x = x, y = y, alternative = "two.sided",
                                    method = "spearman") 
    result$method <- c("Kendall", "Spearman")
    return(result)
  }
  
  
  #分散分析
  if(!is.numeric(x) && is.numeric(y)){
    result$aov$kw <- kruskal.test(y ~ x, data = result$xy) #yが数値
    result$method <- c("Kruskal-Wallis")
    return(result)
  }
  
  #エラーのケース
  if(is.numeric(x) && !is.numeric(y)){
    result$error <- "If x is numeric data, y can not be factor."
    return(result)
  }
  
  
  #分割表の検定
  if(!is.numeric(x) && !is.numeric(y)){
    tab <- table(x, y)
    result$con$fisher <- fisher.test(tab)
    result$con$chisq <- chisq.test(tab)
    result$method <- c("Chi-squared", "Fisher")
    return(result)
  }
}


plot.atv <- function(result){
  if(!is.null(result$error)){return()}
  
  if(is.null(result$con)){
    gp <- ggplot(result$xy, aes(x = x, y = y)) + geom_point()
    print(gp)
  }
  
  if(!is.null(result$con)){
    plot(~ x + y, data = result$xy, 
         col = rainbow(length(unique(c(result$xy[, 1], result$xy[, 2])))))
  }
}


table.atv <- function(result){
  if(class(result) == "atv" && !is.null(result$con)){
    tab <- table(result$xy[, 1], result$xy[, 2])
    return(tab)
  }
}


summary.atv <- function(result, method = NULL){
  if(!is.null(result$error)){return(result$error)}
  if(is.null(method)){method <- result$method[1]}
  
  if(!is.null(result$cor)){
    if(method == "Kendall"){return(result$cor$kendall)}
    if(method == "Spearman"){return(result$cor$spearman)}
  }
  
  if(!is.null(result$aov)){
    if(method == "Kruskal-Wallis"){return(result$aov$kw)}
  }
  
  if(!is.null(result$con)){
    if(method == "Chi-squared"){return(result$con$chisq)}
    if(method == "Fisher"){return(result$con$fisher)}
  }
  
  
}


#コメントアウト ctrl + shift + c
# 
# 
# test <- atv(x = iris$Species, y = iris$Petal.Length)
# plot(test)
# summary(test)
# 
# 
# test2 <- atv(x = iris$Petal.Width, y = iris$Petal.Length)
# plot(test2)
# summary(test2)
# 
# test3 <- atv(x = iris$Species, y = iris$Species)
# plot(test3)
# summary(test3)

#test3 <- atv(x = iris$Species, y = iris$Species)
#plot(test3)



