# Isotope detection or definition approaches


## `CAMERA`

[`CAMERA`](https://bioconductor.org/packages/release/bioc/html/CAMERA.html)
takes a simple approach based on hard coded lower and upper limits for isotope
peaks. How this limits were defined is unclear. For the m/z differences of the
peaks simple lower and upper limits are used, not discriminating between
e.g. C13 and N15 isotopes.

## `envipat`

[`envipat`](https://cran.r-project.org/web/packages/enviPat/) does not seem to
allow identifying isotopes in MS data but does predict an isotope (intensity)
distribution from a chemical formula.


## Breen et al. 2000. Automatic poisson peak harvesting for high throughput protein identification

The authors consider Poisson modelling of isotopic distributions. Given a 
molecule with mass m they find a mapping F between m and the mean M of the 
Poisson distribution model (F: m-> M).
To compute this mapping they derive from a database a hypothetical average 
aminoacid. Next they use this to construct a set of the theoretical peptides 
whose mass span a certain range of interest. They compute the isotopic 
distribution of those and for each one of them they compute M* as the value of M 
that makes Poisson(M) more similar to the isotopic distribution. Finally they 
fit a line for the values of m against the M* and this line represents the 
mapping F. In the end, they model the isotopic distribution of a compound with 
mass m as a Poisson(P(M))

## Park et al. 2008. Isotopic peak intensity ratio based algorithm for determination of isotopic clusters and monoisotopic masses of polypeptides from high-resolution mass spectrometric data

The following statements are reported for the isotopic distribution of a compound 
with elements C, H, N, O, S.
- the intensity of a peak Ik approximates to a polynomial in m (molecular weight) 
  with degree k
- the ratio between consecutive peaks (R) approximates to a linear function in m
- the ratio product between adjacent peaks (RP) approximates to a constant.

For the last two, the more m is big the better the above approximations get.

To find a relation between R and m they consider a large number of polypeptides 
in a certain database spanning a certain range (400-5200 Da) and for them 
they compute R. Then, the interval of interest is divided in two regions 
(at 1800 Da). For high masses a linear approximation is used and 
its coefficients are found by fitting a regression line whereas for low masses
they use a quotient of polynomials (with degree k+1 and k for the k-th R)

The algorithm to cluster isotopic peaks after peak peaking) involves:

- pseudocluster identification. It requires to loop over all the peaks and for
  each of them find groups of peaks starting with the current peak and separated
  by +1 (in the single charged case) for each peak. They first enumerate
  pseudoclusters with two peaks, then pseudoclusters with more peaks and then
  proceed by considering different charged states.
- isotopic cluster identification. Among the pseudoclusters, they identify
  isotopic clusters whose intensity patterns are similar to those of the
  isotopic distributions in terms of R and RP in the pseudocluster.
- duplicate cluster removal. In case two clusters overlap they remove the one
  whose most abundant peak is smaller. If the most abundant peaks are the same,
  the one with the lowest charge state is removed. If their charge states are
  also the same, the cluster with the lower "similarity score" is removed.

## Valkenborg et al. 2008. A Model-Based Method for the Prediction of the Isotopic Distribution of Peptides

Also in this article the authors consider the ratios between peak heights.
They model it as a polynomial model in m (monoisotopic mass) whose order 
is empirically determined by looking at the improvements obtained by adding 
higher order terms.
The parameters of the polynomial model are estimated using the least-squares 
method on different sets of theoretical peptides (and the model is valid in the 
corresponding mass range).
By comparing the ratios between a series of peaks observed in a spectrum with 
the ratios predicted from the model and selecting a treshold for the allowed 
"difference" they decide whether the series of peaks is part of an isotopic 
group or not.

## sgibb

As far as I have understood sgibb uses a mixed approach. He uses the approach of 
Park et al. 2008 but for checking if a candidate cluster is a isotope cluster, 
for which he uses the Poisson approach of Breen et al. 2000.

