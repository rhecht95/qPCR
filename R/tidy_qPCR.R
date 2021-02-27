#Function for tidying raw data output from QuantStudio

#' Initial tidying of raw qPCR data from QuantStudio
#'
#' Applies R friendly names to variables, creates grouping index based on number of samples per target
#'
#' @return data frame
#' @importFrom janitor clean_names
#' @importFrom magrittr "%>%"
#' @import tidyverse

#'
#' @examples
#' tidy_df <- tidy_qPCR()
#'
#' @export
tidy_qPCR <- function(df_raw, group_size, ref_tgt, exp_tgt) {

tidy_df <- df_raw %>%
    clean_names() %>%
    select(well, well_position, sample_name, target_name, ct, ct_mean, ct_sd, ct_threshold) %>%
    dplyr::mutate(group_index = rep(1:ceiling(nrow(df_raw)%/%group_size), each = group_size),
           target_class = case_when(
             stringr::str_detect(target_name, ref_tgt) ~ "house",
             stringr::str_detect(target_name, exp_tgt) ~ "exp"),
           target_class = as.factor(target_class))

tidy_df

}
