\name{corr}
\alias{corr}
\alias{sdev}
\title{2nd momments of sparse matrices}
\description{
Correlation and deviation in sparse matrices.}
\usage{
corr(x, y)
sdev(x)
}
\arguments{
  \item{x}{A \code{dgCMatrix} or \code{matrix} of counts. }
  \item{y}{A \code{matrix} with \code{nrow(y)=nrow(x)}. }
}
\value{
\code{corr} returns the \code{ncol(x)} by \code{ncol(y)} matrix of correlation between x and y, and \code{sdev} returns the column standard deviations.
}
\author{
  Matt Taddy \email{taddy@chicagobooth.edu}
}
\examples{
# some congress examples
data(congress109)
r <- corr(congress109Counts, congress109Ideology$repshare)
## 20 terms for Democrats
sort(r[,1])[1:20]
## 20 terms for Republicans
sort(r[,1], decreasing=TRUE)[1:20]
## 20 high variance terms
colnames(congress109Counts)[
	order(-sdev(congress109Counts))[1:20]]
 
 }
\seealso{ pls, congress109 }
