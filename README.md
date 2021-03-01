
# qPCR

<!-- badges: start -->
<!-- badges: end -->

qPCR is a package designed for wrangling and analyzing raw excel qPCR data output from QuantStudio Applied Biosystems instruments

## Installation

You can install the released version of qPCR from [Github](https://rhecht95/qPCR) with:

``` r
install.packages("qPCR")
```

## Example Workflow

``` r
library(qPCR)

qPCR_df <- load_raw() %>% 
  tidy_qPCR() %>% 
  dCt() %>% 
  ddCt()

```

