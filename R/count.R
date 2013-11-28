## Tools for manipulation of text count matrices ##
stm2dgC <- function(x){
  sparseMatrix(i=x$i, j=x$j, x=x$v,
        dims=dim(x),dimnames=dimnames(x)) }

## normalizing counts by row totals.
normalize <- function(x, byrow=TRUE){
    if(inherits(x,"simple_triplet_matrix")) x <- stm2dgC(x)
    if(byrow){ s <- rowSums(x)
               s[s==0] <- 1
               return( x/s ) }
    else{
      s <- colSums(x)
      s[s==0] <- 1
      return(t(t(x)/s)) }
}

## converting a count matrix to tfidf
tfidf <- function(x){  
  if(inherits(x,"simple_triplet_matrix")) x <- stm2dgC(x)
  idf <- log( nrow(x) ) - log(colSums(x>0) + 1)
  t( t(x) * idf )
}

## correlation for slam simple_triplet_matrix and regular matrix
corr <- function(x, y){
  if(inherits(x, "simple_triplet_matrix")) x <- stm2dgC(x)
  if(!inherits(x, "dgCMatrix")){ return(cor(x,y) ) }

  n <- nrow(x)
  v <- t(scale(y))
  
  r <- tcrossprod(t(x)/sdev(x), v)/(n-1)
  dimnames(r) <- list(dimnames(x)[[2]], dimnames(y)[[2]])
  return( r ) }
  
## column standard deviation for a simple_triplet_matrix 
sdev <- function(x){
  if(inherits(x, "simple_triplet_matrix")) x <- stm2dgC(x)
  if(!inherits(x, "dgCMatrix")){ return(apply(as.matrix(x),2,sd)) }
  n <- nrow(x)
  s <- sqrt(colSums(x^2)/(n-1) - colSums(x)^2/(n^2 - n)) 
  return(s)  }

## Dirichlet RNG
rdir <- function(n, alpha)
{
    x <- matrix(rgamma(length(alpha)*n,alpha),nrow=n,byrow=TRUE)
    return(t(x/rowSums(x))) }
