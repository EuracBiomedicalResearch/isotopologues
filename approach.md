$\require{mhchem}$

## Background

In a compound each atom of a given element can be in one of its isotope forms
(e.g. $C$ can be present either as $\ce{^{12}C}$ or $\ce{^{13}C}$) with the
natural occurring prevalence of each form being known for each
element. That results in the possibility of having different isotopologues
of the same compound. Each of them is characterized by a certain isotopic
substitution specifying for each element the number and the isotopic form of the
atoms with heavier form. The mass difference relative to the monoisotopic
form is equal to the sum of the mass differences of the individual isotopes of
the isotopic substitution. The probability of observing a certain isotopic
substitution is equal to the product of the probabilities of observing the
subset of the substitution involving a certain element within the atoms of that
element in the compound. These probabilities follow a multinomial distribution.
The ratio between the probabilities of an isotopologue and the monoisotopic one
depends only on the elements of the isotopic substitution characterizing the
isotopologue (i.e. those for which some heavier isotopes are present).
Finally, the observed ratio between the intensities of these isotopologues is
expected to approximate the ratio of their probabilities.

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

In detail, we first identify the isotopic substitutions that most frequently
(among HMBD compunds) result in an isotopologue with probability (to be
observed) higher than a certain threshold. For each of the selected
substitutions we consider all the compounds where the substitution is possible
and for each of these compounds we record the (monoisotopic) mass and the ratio
between the probability of the isotopologue the substitution induces and the
monoisotopic one. For each substitution we then compute mass dependent upper
and lower bound lines for the probability ratios. Since only for substitutions
featuring a single element the ratios seem to have an approximately linear trend
we decided to split the mass range into smaller segments and use piecewise
linear bound lines. For each isotopic substitution we thus determine and export
the parameters defining such lines along with the mass difference the
substitution induces.

To identify and group potential isotopologues in MS1 spectra data, we iterate
over all (increasingly ordered) mass peaks in an MS1 spectrum assuming the
current mass peak to represent the monoisotopic peak of a compound. All mass
peaks with a difference in m/z to that candidate monoisotopic peak matching any
of the mass differences of the selected isotopic substitutions are then
identified. For each candidate isotopologue peak the lower and upper expected
probability ratio is calculated using the previously defined parameters for the
isotopic substitution matched to that peak and the m/z of the monoisotopic peak.
If the intensity ratio between the candidate isotopologue peak and the candidate
monoisotopic one is within the calculated lower and upper probability bounds,
the peaks are considered isotopologues and are grouped. This process is then
repeated for the next mass peaks not being already part of an isotopologue 
group.


## Properties

- Mass difference and isotopologue probability calculations are based on
  functionality from `enviPat`.
- This approach considers isotopologues resulting in a peak and not single
  isotopes of elements separately.
- This approach considers both differences in mass as well as ratios between the
  intensities of a candidate isotopologue and the monoisotopic peak for
  isotopologue peak identification.
- This approach uses observed intensity (probability) ratios between
  isotopologue and monoisotopic peaks for all compounds in HMDB to define
  mass-dependent lower and upper bounds for the expected isotopologue intensity.
  

## Limitations

- The present definitions base on compounds from HMDB and the presented approach
  would hence fail to identify isotopes of e.g. anorganic compounds. Parameters
  would have to be estimated based on the corresponding collection of compounds.
- By using only the most frequent isotopic substitutions we might miss detection
  of less frequent isotopologues.
