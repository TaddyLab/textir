\name{tfidf}
\alias{tfidf}
\title{tf-idf}
\description{
term frequency, inverse document frequency}
\usage{
tfidf(x,normalize=TRUE)
}
\arguments{
  \item{x}{A \code{dgCMatrix} or \code{matrix} of counts. }
  \item{normalize}{Whether to normalize term frequency by document totals.}
}
\value{
A matrix of the same type as \code{x}, with values replaced by the tf-idf
\deqn{ f_{ij} * \log[n/(d_j+1)], }
where \eqn{f_{ij}} is \eqn{x_{ij}/m_i} or \eqn{x_{ij}}, depending on \code{normalize},
and \eqn{d_j} is the number of documents containing token \eqn{j}.
}
\author{
  Matt Taddy \email{taddy@chicagobooth.edu}
}
\examples{
data(we8there)
## 20 high-variance tf-idf terms
colnames(we8thereCounts)[
	order(-sdev(tfidf(we8thereCounts)))[1:20]]
 
 }
\seealso{ pls, we8there }
