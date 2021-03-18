#Function for calculating delta-Ct

#' Delta Ct calculation
#'
#' Subtracts Ct of housekeeping gene from Ct of experimental target and returns values as a new column to input data frame
#'
#' @return data frame
#' @import tidyverse
#' @param df dataframe: most often the output from tidy_qPCR
#' @param group_size numeric: number of rows that have a common target gene
#'
#' @examples
#' qPCR_df <- dCt(df)
#'
#' @export

dCt <- function(df, group_size) {

  #identify indices where target_class == "house"
  house_index <- which(df$target_class %in% "house")

  avg_ct_house <- df %>%
    dplyr::slice(house_index) %>%
    dplyr::group_by(group_index) %>%
    dplyr::slice(1) %>%
    dplyr::pull(cq_mean)


  #identify indices where target_class == "exp"
  exp_index <- which(df$target_class %in% "exp")

  avg_ct_exp <- df %>%
    dplyr::slice(exp_index) %>%
    dplyr::group_by(group_index) %>%
    dplyr::slice(1) %>%
    dplyr::pull(cq_mean)

  #vector with values representing delta Ct for each target/housekeeping pair
  dct <- avg_ct_exp - avg_ct_house

  df <- df %>%
    dplyr::mutate(d_Ct = rep(dct, each = group_size)) %>%
    dplyr::relocate(11, .after = 6)

  df
}


