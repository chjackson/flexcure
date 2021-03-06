% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{LRT}
\alias{LRT}
\title{Likelihood ratio test}
\usage{
LRT(fits, fitg)
}
\arguments{
\item{fits}{an object that stores the results of
curereg fit of the model under the null hypothesis.}

\item{fitg}{an object that stores the results of curereg fit
of the model under the alternative hypothesis.}
}
\value{
\item{LRS }{
the value of the likelihood ratio statistic.
}
\item{pvalue }{
the p value of test under null hypothesis chi-square distribution.
}
}
\description{
Computes the likelihood ratio test.
}
\details{
The objects fitg and fits are obtained
using the usual options passed to the curereg
function.
}
\examples{

# ?rmoeevsm
df <- rmoeevsm(n = 500, mu = 0, sigma = 1, alpha = 1, theta = .2, control = 15)

# Model under the null hypothesis (sigma = 1)
fits <- curereg(Surv(time, status) ~ 1, cureformula = ~ 1,
data = df, timedist = "moee", ncausedist = "bernoulli",
method = "BFGS")

# Model under the alternative hypothesis (sigma != 1)
fitg <- curereg(Surv(time, status) ~ 1, cureformula = ~ 1,
data = df, timedist = "moeev", ncausedist = "bernoulli",
method = "BFGS")
LRT(fits, fitg)

}
\author{
Rumenick Pereira da Silva \email{rumenickps@gmail.com}
}
\seealso{
\code{\link{curereg}}, \code{\link{plot.curereg}}, \code{\link{lines.curereg}}
}
\keyword{test}

