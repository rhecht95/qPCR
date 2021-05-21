#Function for tidying raw data output from QuantStudio

#' Initial tidying of raw qPCR data from QuantStudio
#'
#' Applies R friendly names to variables, creates grouping index based on number of samples per target
#'
#' @return data frame
#' @importFrom janitor clean_names
#' @importFrom magrittr "%>%"
#' @import tidyverse
#' @param df_raw raw excel output from QuantStudio instrument
#' @param group_size numeric: number of rows that have a common target gene
#' @param ref_tgt character: name identifier of housekeeping/reference gene
#' @param exp_tgt character: name identifier of experimental target gene
#'
#' @examples
#' tidy_df <- tidy_qPCR()
#'
#' @export
tidy_qPCR <- function(df_raw, group_size, ref_tgt, exp_tgt) {

tidy_df <- df_raw %>%
    janitor::clean_names() %>%
    dplyr::select(well, well_position, omit, sample, target, cq, cq_mean, cq_sd, threshold) %>%
    dplyr::mutate(group_index = rep(1:ceiling(nrow(df_raw)%/%group_size), each = group_size),
           target_class = dplyr::case_when(
             stringr::str_detect(target, ref_tgt) ~ "house",
             stringr::str_detect(target, exp_tgt) ~ "exp"),
           target_class = as.factor(target_class)) %>%
    dplyr::group_by(sample, target) %>%
    dplyr::mutate(cq_mean = mean(cq, na.rm = T)) %>%
    dplyr::ungroup()

tidy_df

}
