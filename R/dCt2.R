#Function for calculating delta-Ct

#' Delta Ct calculation
#'
#' Subtracts Ct of housekeeping gene from Ct of experimental target and returns values as a new column to input data frame
#'
#' @return data frame
#' @import tidyverse
#' @param df dataframe: most often the output from tidy_qPCR
#' @param endog_cntrl character: list of character names for endogenous control genes to be averaged
#' @param cntrl_num numeric: integer indicating number of endogenous controls to average
#' @param excld_cntrl character: list of endogenous control genes to exclude if not averaging between multiple
#'
#' @examples
#' qPCR_df <- df %>%
#' tidy_qPCR() %>%
#' dCt2()
#'
#' @export

dCt2 <- function(df, endog_cntrl, cntrl_num = 1, excld_cntrl) {

  #when averaging multiple endogenous controls
  if(cntrl_num > 1) {
    norm_df <- df %>%
      dplyr::group_by(sample) %>%
      dplyr::mutate(endog_cntrl_mean = mean(cq_mean[target == endog_cntrl])) %>%
      dplyr::mutate(d_Ct = cq_mean - endog_cntrl_mean) %>%
      dplyr::filter(target_class == "exp") %>%
      dplyr::ungroup()

  }
  #only one endogenous control
  else if(cntrl_num == 1) {
    norm_df <- df %>%
      dplyr::filter(target != excld_cntrl) %>%
      dplyr::group_by(sample) %>%
      dplyr::mutate(d_Ct = cq_mean - cq_mean[target == endog_cntrl]) %>%
      dplyr::filter(target_class == "exp") %>%
      dplyr::ungroup()
  }

  norm_df

}
