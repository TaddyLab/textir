\name{rdir}
\alias{rdir}
\title{Dirichlet RNG}
\description{
Generate random draws from a Dirichlet distribution}
\usage{
rdir(n, alpha)
}
\arguments{
  \item{n}{ The number of observations. }
  \item{alpha}{A \code{vector} of scale parameters, such that \eqn{E[p_j] = \alpha_j/\sum_i\alpha_i}. }
}
\value{
 An \code{n} column matrix containing the observations.
}
\author{
  Matt Taddy \email{taddy@chicagobooth.edu}
}
\examples{
rdir(3,rep(1,6))
 }
