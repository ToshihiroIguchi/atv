#Analysis of two variables

library(ggplot2)

#x,yが両方とも数値か確認
is.xy.numeric <- function(x, y){
  if(is.numeric(x) && is.numeric(y)){return(TRUE)}else{return(FALSE)}
}


#x, yを入力すると、数値か項目か判断して評価可能な検定をすべて行う。
atv <- function(x, y, alternative = "two.sided"){
  
  result <- list(cor = NULL, aov = NULL, con = NULL, 
                 xy = data.frame(x = x, y = y),
                 method = NULL)
  class(result) <- "atv"
  
  #数値vs数値
  #回帰分析
  if(is.numeric(x) && is.numeric(y)){
    result$cor$kendall <- cor.test(x = x, y = y, alternative = alternative,
                                   method = "kendall")
    result$cor$spearman <- cor.test(x = x, y = y, alternative = alternative,
                                    method = "spearman") 
    result$method <- c("Kendall", "Spearman")
    return(result)
  }
  
  
  #分散分析
  if(!is.numeric(x) && is.numeric(y)){
    if(length(unique(x)) == 1){
      result$error <- "More than two factors are required."
      return(result)
    }
    if(length(unique(x)) == 2){
      
      grp1 <- y[grep(unique(x)[1], x)]
      grp2 <- y[grep(unique(x)[2], x)]
      
      result$aov$wilcox <- wilcox.test(grp1, grp2)
      result$aov$ks2 <- ks.test(grp1, grp2)
      result$aov$bm <- brunner.munzel.test(x = grp1, y = grp2)
      
      result$method <- c("Wilcoxon rank sum", "Kolmogorov-Smirnov", "Brunner-Munzel")
    }
    
    
    result$aov$kw <- kruskal.test(y ~ x, data = result$xy) #yが数値
    result$method <- c(result$method, "Kruskal-Wallis")
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


plot.atv <- function(result, xlab = "x", ylab = "y", geom ="point"){
  #geomは、point, violin, boxplotを選べる
  if(!is.null(result$error)){return()}
  
  #分割表（factor vs factor）ではないばあい。
  if(is.null(result$con)){
    gp <- ggplot(result$xy, aes(x = x, y = y)) + xlab(xlab) + ylab(ylab)
    
    #分散分析以外、もしくはpointの場合は点でプロット
    if(is.null(result$aov) || geom == "point"){
      gp <- gp + geom_point()
    }
    
    #バイオリンプロットか、箱ひげ図を選べる。
    if(geom == "violin"){gp <- gp + geom_violin(scale="count")}
    if(geom == "boxplot"){gp <- gp + geom_boxplot()}
    
    print(gp)
  }
  
  #分割表の場合
  if(!is.null(result$con)){
    plot(~ x + y, data = result$xy, 
         col = rainbow(length(unique(c(result$xy[, 1], result$xy[, 2])))),
         xlab =xlab, ylab =ylab)
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
    if(method == "Wilcoxon rank sum"){return(result$aov$wilcox)}
    if(method == "Kolmogorov-Smirnov"){return(result$aov$ks2)}
    if(method == "Brunner-Munzel"){return(result$aov$bm)}
    if(method == "Kruskal-Wallis"){return(result$aov$kw)}
  }
  
  if(!is.null(result$con)){
    if(method == "Chi-squared"){return(result$con$chisq)}
    if(method == "Fisher"){return(result$con$fisher)}
  }
  
  
}




