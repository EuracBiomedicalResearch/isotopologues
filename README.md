# Define parameters for isotopologue detection

This repository contains analyses performed to define parameters to enable
grouping of isotope peaks in MS1 data without a priory knowledge of the chemical
formula of the candidates.

Based on chemical formulas of compounds from a public resource (in our case the
Human Metabolome Database [HMDB](https://hmdb.ca)) the most frequent isotopic
substitutions resulting in peaks with an intensity higher than a given threshold
are identified and subsequently the relationship between their probability
(which is related to the peak's intensity) and mass is investigated.

TODO: expand, explain better...

## Files in this repository

- [isotope-detection-approaches](isotope-detection-approaches.md): short
  overview of other approaches to identify isotope peaks in MS1 data.
