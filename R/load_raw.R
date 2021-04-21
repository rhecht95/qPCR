#Function for loading excel data from QuantStudio output

#' Import and Process Initial Raw Excel Data
#'
#' Takes QuantStudio output excel file and loads into df parsing CT as numeric
#'
#' @return data frame
#' @importFrom readxl read_excel
#' @importFrom here here
#'
#' @examples
#' load_raw()
#'
#' @export
load_raw <- function(path, sheet, cell_range) {

  df_raw <- read_excel(path = here(path), sheet = sheet, range = cell_range)
  df_raw$Cq <- as.numeric(as.character(df_raw$Cq))

  df_raw
}
