#' List Repositories of an Organization
#' @importFrom httr config add_headers GET content
#' @importFrom jsonlite fromJSON
#' @export
list_repos <- function(org){
  url <- paste0('https://api.github.com/orgs/', org, '/repos?type=all')
  # Get token
  token <- get_token()
  config <- httr::config(token=token)
  headers <- httr::add_headers(Accept = 'application/vnd.github.v3+json')
  # Try result
  result <- httr::GET(url, config = config, headers, encode = "json")
  result_content <- content(result, "text")
  result_list <- fromJSON(result_content)
  return(result_list)
}
