textir v2.0
======

This is the textir package for R, implementing the MNIR routines of "<a href="http://amstat.tandfonline.com/doi/full/10.1080/01621459.2012.734168">multinomial inverse regression for text analysis</a>", Taddy (2013 JASA) along with other text mining tools: topic modeling, tfidf weighting, partial least squares.  

Versions 2+ make use of the <a href="http://cran.r-project.org/web/packages/distrom/index.html">distrom</a> package, for DMR as in "<a href="http://arxiv.org/abs/1311.6139">distributed multinomial regression</a>", Taddy (2013). These algorithms differ from those in the original MNIR in significant ways: penalties are chosen from full regularization paths (instead of being fixed), via the <a href="http://arxiv.org/abs/1308.5623">gamma lasso</a> algorithm as implemented in <a href="http://cran.r-project.org/web/packages/gamlr/index.html">gamlr</a> (instead of exact log penalties), in parallel for independent Poisson log regressions (instead of jointly for a full multinomial likelihood).  It also uses replaces the slam library for sparse simple triplet matrices with the more common Matrix library.

The last pre-2.0 version of textir, matching the implementation in the original MNIR paper, is <a href="http://www.cran.r-project.org/src/contrib/textir_1.8-8.tar.gz">textir_1.8-8</a>.

