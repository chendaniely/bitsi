gen_pt_info_acq <- function(
    display_name,
    language,
    today_date,
    today_acq_score,
    previous_date = NA,
    previous_acq_score = NA) {

  pt_values_acq <- list(
    language = language,
    name = display_name,
    display_name = display_name, # name and display name are coming from the same input
    today_acq = today_acq_score,
    today_date = today_date,
    today_date_text = NA_character_,
    previous_acq = previous_acq_score,
    previous_date = previous_date,
    previous_date_text = NA_character_,
    acq_interpretive_statement = NA_character_,
    acq_score_statement = NA_character_,
    acq_progress_statement = NA_character_
  )
  
  if (is.na(pt_values_acq$previous_acq)) {
    pt_values_acq$previous_date_text <- ""
    pt_values_acq$acq_progress_statement <- ""
  } else {
    previous_date_date <- as.Date(pt_values_acq$previous_date)
    pt_values_acq$previous_date_text <- strftime(previous_date_date, "%m/%d/%y")
    pt_values_acq$acq_progress_statement <- gen_acq_progress_statment(
      pt_values_acq$today_acq,
      pt_values_acq$previous_acq,
      pt_values_acq$language)
  }
  
  # TODO: not using today date for just the base arrow image
  # today_date_date <- as.Date(pt_values_acq$today_date)
  # pt_values_acq$today_date_text <- gen_acq_date_blob(
  #   today_date_date, pt_values_acq$language
  # )
  
  pt_values_acq$acq_interpretive_statement <- gen_acq_interpretive_statement_blob(
    pt_values_acq$today_acq,
    pt_values_acq$language
  )
  
  if (pt_values_acq$language == "spanish") {
    pt_values_acq$acq_score_statement <- sprintf("Su puntaje es %s", pt_values_acq$today_acq)
    pt_values_acq$png_url <- png_url_spanish_acq
    pt_values_acq$acq_rnw_f <- "acq-pamphlet_interrior-spanish.Rnw"
  } else {
    pt_values_acq$acq_score_statement <- sprintf("Your score is %s", pt_values_acq$today_acq)
    pt_values_acq$png_url <- png_url_english_acq
    pt_values_acq$acq_rnw_f <- "acq-pamphlet_interrior-english.Rnw"
  }
  return(pt_values_acq)
}
