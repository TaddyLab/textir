\name{we8there}
\alias{we8there}
\alias{we8thereRatings}
\alias{we8thereCounts}

\title{ On-Line Restaurant Reviews }

\description{
Counts for 2804 bigrams in 6175 restaurant reviews from the site www.we8there.com. }

\details{ The short user-submitted reviews are accompanied by a five-star rating on four specific aspects of restaurant quality - food, service, value, and atmosphere - as well as the overall experience.  The reviews originally appear in Maua and Cozman (2009), and the parsing details behind these specific counts are in Taddy (MNIR; 2013). }

\value{
   \item{we8thereCounts}{ A \code{dgCMatrix} of phrase counts indexed by review-rows and bigram-columns.}
   \item{we8thereRatings}{ A \code{matrix} containing the associated review ratings. }
}

\references{ 
Maua, D.D. and Cozman, F.G. (2009), \emph{Representing and classifying user reviews}. In ENIA '09: VIII Enconro Nacional de Inteligencia Artificial, Brazil.

Taddy (2013), \emph{Multinomial Inverse Regression for Text Analysis}.
\url{http://arxiv.org/abs/1012.2098}

Taddy (2013), \emph{Distributed Multinomial Regression}.

}

\author{ 
Matt Taddy, \email{taddy@chicagobooth.edu}
}

\seealso{ dmr, mnlm }

\examples{
## some multinomial inverse regression
## we'll regress counts onto 5-star overall rating
data(we8there)

## cl=NULL implies a serial run. 
## To use a parallel library fork cluster, 
## uncomment the relevant lines below. 
## Forking is unix only; use PSOCK for windows
cl <- NULL
# cl <- makeCluster(detectCores(), type="FORK")
## small nlambda for a fast example
fits <- mnlm(cl, we8thereRatings[,'Overall',drop=FALSE], 
			we8thereCounts, bins=5, gamma=1, nlambda=10)
# stopCluster(cl)

## plot fits for a few individual terms
terms <- c("first date","chicken wing",
			"ate here", "good food",
			"food fabul","terribl servic")
par(mfrow=c(3,2))
for(j in terms)
{ 	plot(fits[[j]]); mtext(j,font=2,line=2) }
 
## extract coefficients
B <- coef(fits)
mean(B[2,]==0) # sparsity in loadings
## some big loadings in IR
B[2,order(B[2,])[1:10]]
B[2,order(-B[2,])[1:10]]

## do MNIR projection onto factors
z <- srproj(B,we8thereCounts) 

## fit a fwd model to the factors
summary(fwd <- lm(we8thereRatings$Overall ~ z)) 

## truncate the fwd predictions to our known range
fwd$fitted[fwd$fitted<1] <- 1
fwd$fitted[fwd$fitted>5] <- 5
## plot the fitted rating by true rating
par(mfrow=c(1,1))
plot(fwd$fitted ~ factor(we8thereRatings$Overall), 
	varwidth=TRUE, col="lightslategrey")

}
