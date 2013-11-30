\name{congress109}
\alias{congress109}
\alias{congress109Ideology}
\alias{congress109Counts}

\title{ Ideology in Political Speeches }

\description{ Phrase counts and ideology scores by speaker for members of the 109th US congress. }

\details{ This data originally appear in Gentzkow and Shapiro
(GS; 2010) and considers text of the 2005 Congressional Record,
containing all speeches in that year for members of the United States
House and Senate. In particular, GS record the number times each of
529 legislators used terms in a list of 1000 phrases (i.e., each
document is a year of transcripts for a single speaker). Associated
sentiments are repshare -- the two-party vote-share from each
speaker's constituency (congressional district for representatives;
state for senators) obtained by George W. Bush in the 2004
presidential election -- and the speaker's first and second
common-score values (from http://voteview.com). Full
parsing and sentiment details are in Taddy (2013; Section 2.1). }

\value{
   \item{congress109Counts}{ A \code{dgCMatrix} of phrase counts indexed by speaker-rows and phrase-columns.}
   \item{congress109Ideology}{ A \code{data.frame} containing the associated \code{repshare} and common scores \code{[cs1,cs2]}, as well as speaker
   characteristics: \code{party} (`R'epublican, `D'emocrat, or `I'ndependent), \code{state}, and \code{chamber} (`H'ouse or `S'enate). }
}

\references{ 
Gentzkow, M. and J. Shapiro (2010), \emph{What drives media slant? Evidence from U.S. daily newspapers}. Econometrica 78, 35-7.  The full dataset is at \url{http://dx.doi.org/10.3886/ICPSR26242}.

Taddy (2013), \emph{Multinomial Inverse Regression for Text Analysis}.
\url{http://arxiv.org/abs/1012.2098}
}

\author{ 
Matt Taddy, \email{taddy@chicagobooth.edu}
}

\seealso{ mnlm, pls, dmr, we8there }

\examples{
data(congress109)

## Bivariate sentiment factors (roll-call vote common scores)
covars <- data.frame(gop=congress109Ideology$party=="R",
					cscore=congress109Ideology$cs1)
covars$cscore <- covars$cscore - 
	tapply(covars$cscore,covars$gop,mean)[covars$gop+1]
rownames(covars) <- rownames(congress109Ideology)
cl <- makePSOCKcluster(detectCores())
fitCS <- mnlm(cl, covars, congress109Counts, bins=5,gamma=1)
stopCluster(cl)

## plot the fit
par(mfrow=c(1,2))
for(j in c("estate.tax","death.tax")){
	plot(fitCS[[j]], col=c("red","green"))
	mtext(j,line=2) }
legend("topright",bty="n",fill=c("red","green"),legend=names(covars))


## plot the IR sufficient reduction space
Z <- srproj(fitCS, congress109Counts)
par(mfrow=c(1,1))
plot(Z, pch=21, bg=c(4,3,2)[congress109Ideology$party], main="SR projections")
## two pols
Z[c(68,388),]
}
