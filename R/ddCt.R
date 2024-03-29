#Function for calculating delta delta Ct

#' Delta Delta Ct calculation
#'
#' Subtracts the delta Ct values from a control condition from the delta Ct values of experimental condition
#'
#' @return data frame
#' @import tidyverse
#' @importFrom magrittr "%>%"
#' @param df data frame containing column with dCt values generated by dCt()
#' @param cntrl_cond the sample_name of the control condition in the experiment
#'
#' @examples
#' ddCt_df <- ddCt(df)
#'
#' @export
#'

ddCt <- function(df, cntrl_cond) {

#substracts dCt values of control condition from dCt values in experimental conditions

  ddct <- df %>%
      dplyr::filter(stringr::str_detect(df$sample, "-RT|- RT") == FALSE)
  ddct <- ddct %>%
      dplyr::group_by(sample) %>%
      dplyr::mutate(dd_Ct = d_Ct - ddct$d_Ct[ddct$sample == cntrl_cond]) %>%
      dplyr::ungroup()

  ddct





}
