---
title: Collaboration
format: html
---
# Collaboration
## In 3-4 sentences, describe your participation in peer feedback. Give examples for how you were thorough and constructive.
I provided very thorough feedback/contributions for both Liam and Rachel. 

For Liam, I outlined specific areas where he could satisfy requirements for the automate, organize, and document spec, while also calling out what was done well. For example, for the automate spec, I mentioned that the moving average function definition looked really good but was housed in two places - both in the standalone moving-average.R script, as well as in the paper.qmd file. I noted that it might be more clear for the reader to only have the moving average function in the moving-average.R script.

For Rachel, I contributed a line of code to her moving-average.R script (along with explanatory comments in the code and a thorough comment in the github issue thread) that would enable her to plot her figure. I noticed that in her scratch code ggplot, it wasn't plotting by site - likely because there was no site column in the tibble from the moving-average.R script. I suggested adding a site column to her tibble, so that her combined dataframe would ultimately retain the site ID (BQ1, BQ2, BQ3, PRM).

## Provide links to 3 closed issues that resulted from the self assessment and/or peer review.
https://github.com/cllorey/cll214final/issues/5
https://github.com/cllorey/cll214final/issues/4
https://github.com/cllorey/cll214final/issues/3

## Provide a link to the commit on GitHub where you resolved a merge conflict.
https://github.com/cllorey/cll214final/commit/1e5d097c6ef36b2c976df1b63fe808cfdf852b9f