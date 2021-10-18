# Define parameters for isotopologue detection

This repository contains analyses performed to define parameters to enable
grouping of isotope peaks in MS1 data without a prior knowledge of the chemical
formula of the candidates.

Based on chemical formulas of compounds from a public resource (in our case the
Human Metabolome Database [HMDB](https://hmdb.ca)) the most frequent isotopic
substitutions resulting in peaks with an intensity higher than a given threshold
are identified and subsequently the relationship between their probability
(which is related to the peak's intensity) and mass is investigated.

Background information and a more detailed description is provided
[here](approach.md).

The parameters estimated here can then be used to identify and group mass peaks
in a MS1 spectrum potentially representing signal from
[isotopologues](https://goldbook.iupac.org/terms/view/I03351) of the same
compound.


## Files in this repository

- [isotope-detection-approaches](isotope-detection-approaches.md): short
  overview of other approaches to identify isotope peaks in MS1 data.
- [hmdb_subst_neutral.Rmd](hmdb_subst_neutral.Rmd): R markdown document to
  define parameters for (neutral) HMDB compounds.
- [hmdb_subst_negative.Rmd](hmdb_subst_negative.Rmd): R markdown document to
  define parameters for most common negative adducts of HMDB compounds.
- [hmdb_subst_positive.Rmd](hmdb_subst_positive.Rmd): R markdown document to
  define parameters for most common positive adducts of HMDB compounds.
