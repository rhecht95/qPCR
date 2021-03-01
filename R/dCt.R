#Function for calculating delta-Ct

#' Delta Ct calculation
#'
#' Subtracts Ct of housekeeping gene from Ct of experimental target and returns values as a vector
#'
#' @return vector
#' @import tidyverse
#' @param dataframe
#'
#' @examples
#' delta_Ct_values <- dCt(df)
#'
#' @export

dct <- function(df) {

  #identify indices where target_class == "house"
  house_index <- which(df$target_class %in% "house")

  avg_ct_house <- df %>%
    dplyr::slice(house_index) %>%
    dplyr::group_by(group_index) %>%
    dplyr::slice(1) %>%
    dplyr::pull(ct_mean)


  #identify indices where target_class == "exp"
  exp_index <- which(df$target_class %in% "exp")

  avg_ct_exp <- df %>%
    dplyr::slice(exp_index) %>%
    dplyr::group_by(group_index) %>%
    dplyr::slice(1) %>%
    dplyr::pull(ct_mean)

  #vector with values representing delta Ct for each target/housekeeping pair
  dCt <- avg_ct_exp - avg_ct_house

  return(dCt)
}


