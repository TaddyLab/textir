textir v2.0
======

This is the textir package for R, implementing the MNIR routines of "<a href="http://amstat.tandfonline.com/doi/full/10.1080/01621459.2012.734168">multinomial inverse regression for text analysis</a>".  It also provides a minimalist partial least squares algorithm.    

The cran page is at https://CRAN.R-project.org/package=textir.

Versions 2+ make use of the <a href="https://CRAN.R-project.org/package=distrom">distrom</a> package, for DMR as in "<a href="http://arxiv.org/abs/1311.6139">distributed multinomial regression</a>". These algorithms differ from those in the original MNIR in significant ways: penalties are chosen from full regularization paths (instead of being fixed), via the <a href="http://arxiv.org/abs/1308.5623">gamma lasso</a> algorithm as implemented in <a href="https://CRAN.R-project.org/package=gamlr">gamlr</a> (instead of exact log penalties), in parallel for independent Poisson log regressions (instead of jointly for a full multinomial likelihood).  It also uses replaces the slam library for sparse simple triplet matrices with the more common Matrix library.

I have kept the mnlm function in textir for backwards compatability, but for simplicity recommend  that you use distrom's dmr instead.  The argument list is exactly the same (mnlm just calls dmr).

The last pre-2.0 version of textir, matching the implementation in the original MNIR paper, is textir_1.8-8.  This is available in archives on the cran page.

