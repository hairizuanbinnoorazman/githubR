#' Get User Information on a user
#' @param username Github Username
#' @importFrom httr GET add_headers config
#' @export
get_user <- function(username){
  url <- paste0('https://api.github.com/users/', username)
  # Get token
  token <- get_token()
  config <- httr::config(token=token)
  headers <- httr::add_headers(Accept = 'application/vnd.github.v3+json')
  # Try result
  result <- httr::GET(url, config = config, headers, encode = "json")
  return(result)
}
