library(NSM3)


Steel_Dwass <- function(x, g, result, calc = TRUE){
  if(!is.numeric(x) || !is.factor(g) 
     || is.null(result$aov$kw) || !calc){return(" ")}
  
  ret <- pSDCFlig(x = x, g = g)
  return(ret)
  
}
