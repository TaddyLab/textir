\name{counts}
\alias{corr}
\alias{sdev}
\alias{tfidf}
\alias{normalize}
\title{Utilities for count matrices}
\description{
Various tools for calculation and generation of (sparse) count matrices.}
\usage{
normalize(x,byrow=TRUE)
tfidf(x)
corr(x, y)
sdev(x)
}
\arguments{
  \item{x}{A \code{dgCMatrix} or \code{matrix} of counts. }
  \item{y}{A \code{matrix} with \code{nrow(y)=nrow(x)}. }
  \item{byrow}{Whether to normalize by row or column totals.}
}
\value{
 \code{normalize} divides the counts by row or column totals, \code{corr} returns the \code{ncol(x)} by \code{ncol(y)} matrix of correlation between x and y, \code{sdev} returns the column standard deviations, and  \code{tfidf} returns a matrix with entries \eqn{x_{ij} \log[ n/(d_j+1) ]}, where \eqn{x_{ij}} is term-j frequency in document-i, 
and \eqn{d_j} is the number of documents containing term-j.
}
\author{
  Matt Taddy \email{taddy@chicagobooth.edu}
}
\examples{
# simple normalize
normalize( matrix(1:9, ncol=3) )
normalize( matrix(1:9, ncol=3), byrow=FALSE )

# some congress examples
data(congress109)
r <- corr(congress109Counts, congress109Ideology$repshare)
## 20 terms for Democrats
sort(r[,1])[1:20]
## 20 terms for Republicans
sort(r[,1], decreasing=TRUE)[1:20]
## 20 important terms
colnames(congress109Counts)[
	order(-sdev(tfidf(congress109Counts)))[1:20]]
 
 }
\seealso{ pls, congress109 }
