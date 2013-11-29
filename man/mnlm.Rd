\name{mnlm}
\alias{mnlm}
\title{
Estimation for high-dimensional Multinomial Logistic Regression
}
\description{
MAP estimation of multinomial logistic regression models.   Note that this is currently nothing more than a wrapper of \code{dmr}; it remains a separate function only for legacy reasons and with potential for future separate development. 
  }
\usage{
mnlm(cl, covars, counts, mu=NULL, bins=NULL, verb=0, ...)
}
\arguments{
 \item{cl}{A \code{parallel} library socket cluster.  See the same argument in \code{help(dmr)} for details. }
\item{covars}{A dense \code{matrix} 
      or sparse \code{Matrix} of covariates.
      This should not include the intercept.  See the same argument in \code{help(dmr)} for details.  }
\item{counts}{A dense \code{matrix} 
      or sparse \code{Matrix} of
      response counts. See the same argument in \code{help(dmr)} for details. }
\item{mu}{
  Pre-specified fixed effects for each observation in the Poisson regression linear equation.  See the same argument in \code{help(dmr)} for details.  }
\item{bins}{Number of bins into which we will attempt to collapse each column of \code{covars}.  \code{bins=NULL}
 does no collapsing. See the same argument in \code{help(dmr)} for details.}
\item{verb}{Whether to print some info.  See the same argument in \code{help(dmr)} for details.}
\item{...}{Additional arguments to \code{gamlr} from \code{dmr}.  See \code{help(gamlr)} for details.}
}
\details{
 Finds the posterior mode for multinomial logistic regression
 parameters using cyclic coordinate descent on a factorized Poisson likelihood.  The \code{mnlm} function is a simple wrapper of the \code{dmr} function of the \code{distrom} library, which itself relies upon the \code{gamlr} library.  For prediction, coefficients, and plotting see the relevant functions in \code{help(dmr)}.

 This is designed to be useful for multinomial inverse regression (MNIR) analysis of text,  but should be 
 useful for any large-scale logistic regression.
  Additional details are available in Taddy (2013).   }
\value{
 Returns a \code{dmr} s3 object.  See \code{help(dmr)} for details.}
\references{
Taddy (2013), \emph{Multinomial Inverse Regression for Text Analysis}.
\url{http://arxiv.org/abs/1012.2098}
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

## applies AIC selection by default
round(coef(fit),1) 
round(predict(fit, newdata, type="response"),1)
par(mfrow=c(1,3))
for(j in c("a","b","c")){ 
  plot(fit[[j]]); mtext(j,line=2) }
 
}