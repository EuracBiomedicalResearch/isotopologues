$\require{mhchem}$

## Background

In a compound with $n$ atoms of element $X$ ($n_X$) each of the atoms can be in
a specific isotope form $\ce{ ^{y}X }$ such as $\ce{^{12}C}$ or $\ce{^{13}C}$
(with the natural occurring prevalence of each isotope form for each element
being known). The probability of observing a certain isotope for an atom depends
on the number of these atoms in the compound. In addition, the atoms of each
element in a compound can be in specific isotopic forms hence forming an
isotopologue of the compound which is characterized by the number of isotopic
substitutions it consists of. The mass difference relative to the monoisotopic
form is equal to the sum of the mass differences of the individual isotopes of
the isotopic substitution. The probability of observing a certain isotopic
composition is equal to the product of the probabilities of the isotopes of each
of the compound's elements with the probability of each isotope following a
multinomial distribution. The ratio between the probabilities of the
monoisotopic form and another isotopic composition of a compound depends only on
the elements of the isotopic substitution by which these isotopologues
differ. Finally, the ratio between the intensities of these isotopologues is
expected to be equal to the ratio of their probabilities.

The mass as well as the probability of an isotopologue can be determined if the
chemical formula and the isotopic composition of the isotopologue is known.


## Approach

To identify mass peaks potentially representing isotopologues of the same
compound even without prior knowledge of the compound's chemical formula or the
exact isotopic composition of the individual peaks, we analyze the mass
differences and probabilities for the most frequently observed isotopic
substitutions on a large data set of known compounds. As a result we define
parameters that allow us to model probability ratios between monoisotopic peaks
and isotopologue peaks as a function of the compound's mass (respectively of the
m/z of its ion). As a data set we use in the present setup all compounds defined
in the Human Metabolome Database ([HMDB](https://hmdb.ca)).

In detail, we first identify the most frequent isotopic substitutions with a
probability (and hence intensity) higher than a certain threshold. For all
compounds with that substitution, we then record the compound's mass, the mass
difference of the substitution and the ratio between the probability of the
monoisotopic form and the substitution. This information is then used to model
for each isotopic substitution the observed probability ratios as a function of
the compounds' masses. For substitutions consisting of a single isotope, an
approximately linear relationship can be observed. To accommodate also
non-linear relationships, we split the mass range into smaller segments and
define in each of these segments a linear relationship between the compounds
mass and a lower and upper bound of the probability ratio. For each isotopic
substitution we thus determine and export the parameters to calculate these
lower and upper probability ratios for each segment along with the mass
difference of the substitution.

To identify and group potential isotopologues in MS1 spectra data, we iterate
over all (increasingly ordered) mass peaks in an MS1 spectrum assuming the
current mass peak to represent the monoisotopic peak of a compound. All mass
peaks with a difference in m/z to that candidate monoisotopic peak matching any
of the mass differences of defined isotopic substitutions are then
identified. For each candidate isotopologue peak the lower and upper expected
probability ratio is calculated using the previously defined parameters for that
isotopic substitution and the m/z of the monoisotopic peak. If the intensity
ratio between the candidate monoisotopic and isotopologue peak is within these
calculated lower and upper probability ratio bounds, the peaks are considered
isotopologues and are grouped. This process is then repeated for the next mass
peak not being already part of an isotopologue group.


## Properties

- Mass difference and isotopologue probability calculations are based on
  functionality from `enviPat`.
- This approach considers isotopologues resulting in a peak and not single
  isotopes of elements separately.
- This approach considers both differences in mass as well as ratios between the
  intensities of an candidate isotopologue and monoisotopic peaks for
  isotopologue peak identification.
- This approach uses observed intensity (probability) ratios between
  isotopologue and monoisotopic peaks for all compounds in HMDB to define
  mass-dependent lower and upper bounds for the expected isotopologue intensity.
  

## Limitations

- The present definitions base on compounds from HMDB and the presented approach
  would hence fail to identify isotopes of e.g. anorganic compounds. Parameters
  would have to be estimated based on corresponding collection of compounds.
- By using only the most frequent isotopic substitutions we might miss detection
  of less frequent isotopologues.
