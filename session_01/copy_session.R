
copy_session <- function(session) {
  file.copy(paste0("session_", session), "../r_shiny_intro_data/", overwrite = TRUE, recursive = TRUE, copy.date = TRUE)
  file.copy(list.files(pattern = paste0("^", session, "-.*html")), "../r_shiny_intro_data/slides/", overwrite = TRUE, recursive = TRUE, copy.date = TRUE)
}

copy_session("01")
