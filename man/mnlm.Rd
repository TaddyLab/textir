\name{mnlm}
\alias{mnlm}
\alias{srproj}
\title{
Multinomial Inverse Regression (MNIR)}
\description{
Estimation of high dimensional multinomial logistic regression models and the corresponding MNIR sufficient reduction projections.   
  }
\usage{
mnlm(cl, covars, counts, mu=NULL, bins=NULL, verb=0, ...)
srproj(obj, counts, dir=1:K, ...)
}
\arguments{
 \item{cl}{A \code{parallel} library socket cluster.  See the same argument in \code{help(dmr)} for details. }
\item{covars}{A dense \code{matrix} 
      or sparse \code{Matrix} of covariates.
      This should not include the intercept.  See the same argument in \code{help(dmr)} for details.  }
\item{counts}{A dense \code{matrix} 
      or sparse \code{Matrix} of
      response counts (e.g., token counts in text mining). 
      See the same argument in \code{help(dmr)} for details. For \code{srproj},
      this must have the same number of columns as the response dimensions (vocabulary size) in \code{obj}.}
\item{mu}{
  Pre-specified fixed effects for each observation in the Poisson regression linear equation.  See the same argument in \code{help(dmr)} for details.  }
\item{bins}{Number of bins into which we will attempt to collapse each column of \code{covars}.  \code{bins=NULL}
 does no collapsing. See the same argument in \code{help(dmr)} for details.}
\item{verb}{Whether to print some info.  See the same argument in \code{help(dmr)} for details.}
\item{obj}{Either a \code{dmr} object, as returned from \code{mnlm}, or the \code{dmrcoef} object obtained by calling \code{coef} on the output of \code{mnlm}.  The latter wwill be faster, since \code{coef.dmr} is called inside \code{srproj} otherwise.}
\item{dir}{The attribute (\code{covar}) dimensions onto which you want to project.  
The default is all dimensions: \code{1:K}, where \code{K} is the number of columns in the \code{covars} argument to mnlm.}
\item{...}{Additional arguments to \code{gamlr} from \code{dmr} (via \code{mnlm}), and to \code{coef.dmr} from \code{srproj}.  See \code{help(gamlr)} and \code{help(dmr)} for details.}
}
\details{
These functions provide the first two steps of multinomial inverse regression (see MNIR paper).

 \code{mnlm} fits multinomial logistic regression
 parameters under gamma lasso penalization on a factorized Poisson likelihood.  The \code{mnlm} function is just a simple wrapper of the \code{dmr} function of the \code{distrom} library (see DMR paper), which itself relies upon the \code{gamlr} library (see GL paper).  For model selection, coefficients, prediction, and plotting see the relevant functions in \code{help(dmr)}.

 \code{srproj} calculates the MNIR  Sufficient Reduction projection from text \code{counts} on to the attribute dimensions of interest (\code{covars} in \code{mnlm}).  In particular, for counts \eqn{C}, with row sums \eqn{m}, and \code{mnlm} coefficients \eqn{\phi_j} corresponding to attribute \eqn{j},
 \eqn{z_j = C'\phi_j/m} is the SR projection in the direction of \eqn{j}.  The MNIR paper explains how \eqn{V=[v_1 ... v_K]}, your original covariates/attributes, are independent of text counts \eqn{C} given SR projections \eqn{Z=[z_1 ... z_K]}.  

  The final step of MNIR is `forward regression' for any element of \eqn{V} onto \eqn{Z} and the remaining elements of \eqn{V}.  We do not provide a function for this because you are free to use whatever you want; see the MNIR and DMR papers for linear, logistic, and random forest forward regression examples.

  Note that if you were previously using \code{textir} and \code{dmr} not for inverse regression, but rather just as fast code for multinomial logistic regression, you probably want to work directly with the \code{gamlr} (binary response) or \code{dmr} (multinomial response) packages.
 }
\value{
 \code{mnlm} returns a \code{dmr} s3 object.  See \code{help(dmr)} for details.

 \code{srproj} returns a matrix with columns corresponding to directions \code{dir}, plus an additional column \code{m} holding the row totals of \code{counts}.
 }
\references{
Taddy (2013), \emph{Multinomial Inverse Regression for Text Analysis} (MNIR).
JASA 108.

Taddy (2013), \emph{Distributed Multinomial Regression} (DMR).  arXiv:1311.6139.

Taddy (2013), \emph{The Gamma Lasso} (GL).  arXiv:1308.5623.
}
\author{
  Matt Taddy \email{taddy@chicagobooth.edu}
}
\seealso{
  congress109, we8there, dmr
}
\examples{

### Ripley's Cushing Data; see help(Cushings) ###
library(MASS)
data(Cushings)
Cushings[,1:2] <- log(Cushings[,1:2])
train <- Cushings[Cushings$Type!="u",]
newdata <- as.matrix(Cushings[Cushings$Type == "u", 1:2])

## fit, coefficients, predict, and plot
fit <- mnlm(NULL, 
  covars=train[,1:2], 
  counts=factor(train$Type))

## dmr applies AIC selection by default
round(coef(fit),1) 
round(predict(fit, newdata, type="response"),1)
par(mfrow=c(1,3))
for(j in c("a","b","c")){ 
  plot(fit[[j]]); mtext(j,line=2) }

## see we8there and congress109 for MNIR and srproj examples
 
}