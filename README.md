
# qPCR

<!-- badges: start -->
<!-- badges: end -->

qPCR is a package designed to wrangle and analyze raw, excel qPCR data output from QuantStudio Applied Biosystems instruments

## Installation

You can install the released version of qPCR from [Github](https://rhecht95/qPCR) with:

``` r
install.packages("qPCR")
```

## Example Workflow

``` r
library(qPCR)

raw_df <- load_raw()
tidy_df <- tidy_qPCR(raw_df)
dCt <- dCt(tidy_df) 
```

