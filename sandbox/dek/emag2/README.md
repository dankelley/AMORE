---
title: Dealing with (large) csv files for earth magnetic anomaly
author: Dan Kelley
date: 2023-05-06
---

A world magnetic anomaly file in CSV format was downloaded from Reference 1.  It
is so large that it may be difficult to load on some computers. For example, R
consumed nearly 15 GB of memory on my computer, very close to the 16 GB limit.
Another problem was that the process took nearly 10 minutes to complete.

Given this, the 01 R file reads the CSV and creates a RDA file, which is about
1/5 the size of the CSV file, and can be ready about 70 time faster.  Once the
RDA file has been created, the other R files do various plots, as outlined in
the following.

# Files

## `01_EMAG2_create_rda.R`

* RDA is much faster to load, and consumes much less memory than original CSV.
* read `EMAG2_V3_20170530.csv` (4.0 GB) file, which takes 530 seconds and
  consumes 14.8 GB memory
* create `EMAG2_V3_20170530.rda` (889 MB) used in other R files

## `02_EMAG2_world_monochrome.R`

* create `sealevel_world_monochrome.png` and `upcont_world_monochrome.png`

## `03_EMAG2_NS_monochrome.R`

* plot area near Nova Scotia
* create `sealevel_ns_monochrome.png` and `upcont_ns_monochrome.png`

## `04_EMAG2_NS_bicolour.R`

* as `03_EMAG2_NS_monochrome.R` but use a red-blue colourmap
* create `sealevel_ns_bicolour.png` and `upcont_ns_bicolour.png`

## `05_EMAG2_halifax.R`

* demonstrate lookup.  This is slow only on `load()` part, so that is cached for
  interactive use.
* create `05_EMAG2_halifax.png`


# References

1. Information (NCEI), National Centers for Environmental. “EMAG2v3: Earth
   Magnetic Anomaly Grid (2-Arc-Minute Resolution).” Accessed May 5, 2023.
   https://www.ncei.noaa.gov/access/metadata/landing-page/bin/iso?id=gov.noaa.ngdc.mgg.geophysical_models:EMAG2_V3.

