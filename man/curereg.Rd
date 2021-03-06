% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/curereg.R
\name{curereg}
\alias{curereg}
\title{Parametric regression models with cure fraction for survival data}
\usage{
curereg(formula, cureformula = ~1, data, weights, timedist = "moeev",
  ncausedist = "poisson", subset, na.action, inits, method = "SANN", ...)
}
\arguments{
\item{formula}{an object of class "\code{\link{formula}}" which expresses the model to be fitted.
The response should be specified as an object of class \code{survival} obtained via
\code{\link{Surv}} function and can be set as right, left and interval censored data.
The \code{~} separates the response from the covariates which should be specified on the right
side, for instance \code{formula = Surv(time, status) ~ age + sex}.}

\item{cureformula}{a formula defining the cure rate model. In the case of no covariate effect
on the cure rate, set \code{cureformula = ~ 1} (default), and for instance
\code{cureformula = ~ age + sex} to include coefficients \code{age} and \code{sex} additively.
If \code{cureformula = }  or {\code{cureformula = NULL}} the model will be fitted without any
cure rate.}

\item{data}{the data set of class \code{data.frame} or \code{list} which includes all the
objects defined in \code{formula} and \code{cureformula}. In case unspecified \code{data},
the variables shoud be available in the workspace (see \code{(.GlobalEnv)}).}

\item{weights}{optional prior weights for the data.}

\item{timedist}{survival distribution for the non-cured individuals. This can be set as:
\code{"exp"} (exponential), \code{"weibull"} (Weibull), \code{"ev"} (extreme value),
\code{"gamma"} (Gamma),\code{"lnorm"} (Log-normal), \code{"llogist"} (Log-logistic),
\code{"moee"} (extreme value (or exponential) in the Marshall-Olkin family),
\code{"moeev"} (extreme value (or Weibull) in the Marshall-Olkin family, the default),
\code{"gengamma"} (Generalised Gamma), \code{"genf"} (Generalised F).

The exponential, Weibull, log-normal and log-logistic distributions have the same
parameterization defined in \code{\link{dexp}}, \code{\link{dweibull}}, \code{\link{dlnorm}}
from package \pkg{base} and \code{\link{dllogis}} from package \pkg{flexsurv}, respectively.
respectively. These differ from the parametrization used in the package \pkg{survreg}.
The generalised Gamma and Generalised F distributions follows the parametrisation in
(\code{\link{dgengamma}}) and (\code{\link{dgenf}}), respectively, both available in
\pkg{flexsurv}. For the Marshall-Olkin extreme value distribution see \code{\link{dmoeev}}.}

\item{ncausedist}{distribution of the number of competing causes of the event. This can be
set as \code{ncausedist = "bernoulli"} for the standard mixture model and
\code{ncausedist = "poisson"} (default), for the promotion time model.}

\item{subset}{optional numeric vector specifying the subset observations from the full data set.}

\item{na.action}{a function indicating what should happen when \code{NA}'s occur, with
possible arguments \code{na.omit} and \code{na.fail}. The default is set by the
\code{na.action} setting in \code{options()}.}

\item{inits}{optional list with the initial values for the parameters. This list should be
set as \code{inits = list(coef_cure = c(...), coef_time = c(...),  others = c(...))}
where \code{coef_cure} is the vector of coefficients for the cure model, \code{coef_time}
is the vector of coefficients for the survival regression model and others is parameters
that are not modeled by covariates.  See the object curereg.dists or flexsurv.dists in the
source for the exact methods used.}

\item{method}{The optimisation method to be used. \code{method = "BFGS"} is the default
however "Nelder-Mead", "CG", "L-BFGS-B" and "SANN" can also be used, For more information
about the optimisation methods, see \code{\link{optim}}.}

\item{\dots}{optional arguments for the \code{\link{optim}} and \code{\link{flexsurvreg}}
functions.

For situations where the default \code{optim} arguments results in lack of converge, consider
use \code{control=list(fnscale = value)} with \code{value} a tolerance value with the same
magnitude of the log-likelihood function. Usually that happens when the Hessian matrix is
not positive definite at some step of the numerical optimisation. An useful tool detect this
and verify a possible "slower" convergence is add an appropriate value for \code{trace} to
the \code{control}. See \code{\link{optim}} for more information.

The argument \code{fixedpars} of the \code{flexsurvreg} function allows the user to input a
vector of indices representing the fixed parameters. The arbitrary values for those fixed
parameters should have been specified in \code{inits} argument and remain fixed throughout
the estimation process.}
}
\value{
A list of class "curereg" containing information about the fitted model.
Components of interest to users may include:

\item{call }{
the matched call.
}
\item{coefficients }{
a named vector of coefficients obtained via Maximum Likelihood (see Details).
}
\item{std.error }{
a named vector of the estimated standard errors for the coefficients (see Details).
}
\item{vcov }{
A matrix of the estimated covariances between the coefficient estimates in the predictor
of the model.
}
\item{loglik }{
log-likelihood.
}
\item{AIC }{
AIC the (generalized) Akaike Information Criterion for the fitted model.
}
}
\description{
\code{curereg} fits parametric regression models with cure fraction for survival
data. This function extends the \code{\link{flexsurvreg}} by the inclusion of the cure fraction
in the formulation and adds the Marshall-Olkin extreme value distribution in the comprehensive
roll of parametric distributions avaliable.
}
\details{
Note that the arguments \code{ncausedist} and \code{timedist} set up the model to
be fitted. This means that if \code{ncausedist = "poisson"} and \code{timedist = "genf"}
the fitted model is obtained considering the promotion-time model with generalised F
responses. The improper density function of this model is available in \code{\link{dgenfpt}}.
If \code{ncausedist = "bernoulli"} and \code{timedist = "genf"} has been set then the fitted
model is calculated considering the standard mixture model with generalised F responses.
The improper density function of this model is available in \code{\link{dgenfms}}.
\code{d____ms} and \code{p____ms} correspond to the improper density and probability
functions for standard mixture models, respectively, where \code{____} can be any of the
distributions in \code{timedist}. Similarly, \code{d____pt} and \code{p____pt} correspond
to the improper density and probability functions for promotion time models.

The relationship between the linear predictor in \code{formula} and the time-to-event of
the non-cured elements is logarithmic as in the accelerated failure time models
(Lawless, 2003). However, for \code{cureformula}, if \code{ncausedist = "bernoulli"}
the relationship is similar to a logistic regression model
(\code{family = binomial(link = " logit ")} in \code{glm}) and if
\code{ncausedist = "poisson"} is similar to a Poisson model with logarithmic link
function (\code{family = poisson(link = "log")} in \code{glm}). See the references for
more details.
}
\examples{
## fit Marshall-Olkin extended extreme value standart mixture model
data(e1684)
fitmo <- curereg(Surv(FAILTIME, FAILCENS) ~ TRT + SEX + AGE, cureformula = ~ TRT + SEX + AGE,
                data = e1684, timedist = "moeev", ncausedist = "bernoulli")

# Output of 'curereg' object
fitmo

# Extract Model Coefficients
coef(fitmo)

# Extract model coefficients:
# Terms: failure time distribution model
coef(fitmo, terms = "time")
# Terms: cure probability model
coef(fitmo, terms = "cure")

# Object summaries
summary(fitmo)

# Information criterion
AIC(fitmo) # Akaike information criterion
BIC(fitmo) # Bayesian information criterion

# Extract Log-Likelihood
logLik(fitmo)
# Calculate Variance-Covariance Matrix for a Fitted Model Object
vcov(fitmo)

}
\author{
Rumenick Pereira da Silva \email{rumenickps@gmail.com}
}
\references{
Jackson, C.H. Christopher Jackson (2015). flexsurv: Flexible Parametric Survival and Multi-State Models.
R package version 0.7. https://CRAN.R-project.org/package=flexsurv.

Maller, R. A., & Zhou, X. (1996). Survival analysis with long-term survivors. New York: Wiley.

Lawless, J. F. (2011). Statistical models and methods for lifetime data (Vol. 362). John Wiley & Sons.

Ortega, E. M., Cancho, V. G., & Paula, G. A. (2009). Generalized log-gamma regression models
with cure fraction. Lifetime Data Analysis, 15(1), 79-106.

Peng, Y., Dear, K. B., & Denham, J. W. (1998). A generalized F mixture model for cure rate
estimation. Statistics in medicine, 17(8), 813-830.
}
\seealso{
\code{\link{confint.curereg}} for confidence intervals for the coefficients,
\code{\link{curefraction}} for predict cure fractions from fitted \code{curereg} model,
\code{\link{plot.curereg}} and \code{\link{lines.curereg}} to plot fitted survival, hazards
and cumulative hazards from models fitted by \code{\link{curereg}}.
}
\keyword{models}
\keyword{survival}

