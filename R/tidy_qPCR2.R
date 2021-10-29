#Function for tidying raw data output from QuantStudio

#' Initial tidying of raw qPCR data from QuantStudio
#'
#' Applies R friendly names to variables, tags endogenous controls ("house") or experimental targets by user input
#'
#' @return data frame
#' @importFrom janitor clean_names
#' @importFrom magrittr "%>%"
#' @import tidyverse
#' @param df_raw raw excel output from QuantStudio instrument
#' @param ref_tgt character: name identifier of housekeeping/reference gene(s)
#' @param exp_tgt character: name identifier of experimental target gene(s)
#'
#' @examples
#' tidy_df <- tidy_qPCR()
#'
#' @export
tidy_qPCR2 <- function(df_raw, ref_tgt, exp_tgt) {

  ref_string <- ref_tgt
  tgt_string <- exp_tgt

  tidy_df <- df_raw %>%
    janitor::clean_names() %>%
    dplyr::select(well, well_position, omit, sample, target, cq, cq_mean, cq_sd, threshold) %>%
    dplyr::mutate(target_class = dplyr::case_when(
      stringr::str_detect(target, paste(ref_tgt, collapse = "|")) ~ "house",
      stringr::str_detect(target, paste(exp_tgt, collapse = "|")) ~ "exp")) %>%
    dplyr::mutate(target_class = as.factor(target_class)) %>%
    dplyr::group_by(sample, target) %>%
    dplyr::mutate(cq_mean = mean(cq, na.rm = T)) %>%
    dplyr::ungroup() %>%
    dplyr::group_by(sample)


  tidy_df

}
