#' List Columns in a Project
#' @importFrom httr config add_headers GET
#' @export
list_project_columns <- function(project_id){
  url <- paste0('https://api.github.com/projects/', project_id, '/columns')
  # Get token
  token <- get_token()
  config <- httr::config(token=token)
  headers <- httr::add_headers(Accept = 'application/vnd.github.inertia-preview+json')
  # Try result
  result <- httr::GET(url, config = config, headers, encode = "json")
  result_content <- content(result, "text")
  result_list <- fromJSON(result_content)
  return(result_list)
}

#' Get details on a project column
#' @importFrom httr config add_headers GET
#' @export
get_project_column <- function(project_column_id){
  url <- paste0('https://api.github.com/projects/columns/', project_column_id)
  # Get token
  token <- get_token()
  config <- httr::config(token=token)
  headers <- httr::add_headers(Accept = 'application/vnd.github.inertia-preview+json')
  # Try result
  result <- httr::GET(url, config = config, headers, encode = "json")
  result_content <- content(result, "text")
  result_list <- fromJSON(result_content)
  return(result_list)
}


