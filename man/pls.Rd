\name{pls}
\alias{pls}
\alias{predict.pls}
\alias{summary.pls}
\alias{print.pls}
\alias{plot.pls}
\title{ Partial Least Squares }
\description{ A simple partial least squares procedure. }
\usage{pls(x, y, K=1, scale=TRUE, verb=TRUE) 

\method{predict}{pls}( object, newdata, type="response", ... )

\method{summary}{pls}( object, ... )

\method{print}{pls}(x, ... )

\method{plot}{pls}(x, K=NULL, xlab="response", ylab=NULL, ...)
}
\arguments{
  \item{x}{ The covariate matrix, in either \code{simple_triplet_matrix} or \code{matrix} format. }
   \item{y}{ The response vector.  }
   \item{K}{ The number of desired PLS directions. In plotting, this can be a vector of directions to draw, otherwise directions \code{1:fit$K} are plotted.  }
   \item{scale}{ An indicator for whether to scale \code{x}; usually a good idea. 
   		 If \code{scale=TRUE}, model is fit with x scaled to have variance-one columns.   }
   \item{verb}{ Whether or not to print a small progress script. }

   \item{object}{  For \code{predict} and \code{summary}: a \code{pls} output object.}
   \item{x}{  For \code{plot} and \code{print}: a \code{pls} output object.}
   \item{newdata}{   For \code{predict}, an \code{ncol(x)}-column matrix of 
  		    new observations. Can be either a simple \code{matrix} or a \code{simple_triplet_matrix}.   }
  \item{type}{  For \code{predict}, a choice between output types: predictions scaled to the original response for \code{"response"}, fitted partial least squares directions for \code{"reduction"}. }
   \item{xlab}{ For \code{plot}, the x-axis label. }
   \item{ylab}{ For \code{plot}, the y-axis label. If null, will be set to `pls(k) fitted values' for each k.}
   \item{...}{Additional arguments.}
}
\value{ Output from \code{pls} is a list with the following entries
	\item{y}{The response vector. }
	\item{x}{The unchanged covariate matrix. }
	\item{directions}{The pls directions: \code{x\%*\%loadings - shift}. }
	\item{loadings}{The pls loadings. }
	\item{shift}{ Shift applied after projection to center the PLS directions.}
	\item{fitted}{\code{K} columns of fitted \code{y} values for each number of directions. }
	\item{fwdmod}{ The \code{lm} object from forward regression \code{lm(as.numeric(y)~directions)}. }

\code{predict.pls} outputs either a vector of predicted resonse or an \code{nrow(newcounts)} by \code{ncol(object$loadings)} matrix of pls directions for each new observation. Summary and plot produce return nothing.
}
\details{ \code{pls} fits the Partial Least Squares algorithm described in Taddy (2012; Appendix A.1). 
	In particular, 	we obtain loadings \code{loadings[,k]} as the correlation between
	\code{X} and factors \code{factors[,k]}, where \code{factors[,1]} is initialized      
	at \code{scale(as.numeric(y))} and subsequent factors are orthogonal to
	to the k'th pls direction, an ortho-normal transformation of \code{x\%*\%loadings[,k]}.

\code{predict.pls} returns predictions from the \code{object$fwdmod}
forward regression \eqn{\alpha + \beta*z} for projections \code{z = x*loadings -
shift} derived from new covariates, or if \code{type="reduction"} it just returns these projections.
\code{summary.pls} prints dimension details and a quick summary of the 
	corresponding forward regression. \code{plot.pls} draws response
	 versus fitted values for least-squares fit onto the K pls directions. }
\references{
Taddy (2013), \emph{Multinomial Inverse Regression for Text Analysis}.
Journal of the American Statistical Association 108.

Wold, H. (1975), \emph{Soft modeling by latent variables: The nonlinear iterative partial least squares approach}. 
In Perspectives in Probability and Statistics, Papers in Honour of M.S. Bartlett.

}
\author{ Matt Taddy \email{taddy@chicagobooth.edu} }
\seealso{
  normalize, sdev, corr, congress109
}
\examples{
data(congress109)
x <- normalize(congress109Counts)
summary( fit <- pls(x, congress109Ideology$repshare, K=3) )
plot(fit, pch=21, bg=c(4,3,2)[congress109Ideology$party])
predict(fit, newdata=x[c(68,388),])
}

