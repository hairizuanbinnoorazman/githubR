#' List Comments in an Issue
#' @param owner The owner of the repository. In a repo name, it would be the part before the slash.
#' @param repo The name of the repository
#' @param number Issue Number (NOT issue ID)
#' @param since Only issues updated at or after this time are returned. Format is YYYY-MM-DD
#' @importFrom httr config add_headers GET
#' @export
list_issues_comments <- function(owner, repo, number, since = NULL){
  url <- paste0('https://api.github.com/repos/', owner, '/', repo, '/issues/', number, '/comments')
  # Query parameters
  query_params <- list()
  query_params['since'] <- if(!is.null(since)){paste(as.Date(since), 'T00:00:00Z')} else{NULL}
  # Get token
  token <- get_token()
  config <- httr::config(token=token)
  headers <- httr::add_headers(Accept = 'application/vnd.github.v3+json')
  # Try result
  result <- httr::GET(url, config = config, headers, query = query_params, encode = "json")
  result_content <- content(result, "text")
  result_list <- fromJSON(result_content)
  return(result_list)
}

#' Create Comment in an Issue
#' @param owner The owner of the repository. In a repo name, it would be the part before the slash.
#' @param repo The name of the repository
#' @param number Issue Number (NOT issue ID)
#' @param body The contents of the comment.
#' @importFrom httr config add_headers GET
#' @export
create_issue_comment <- function(owner, repo, number, body = NULL){
  url <- paste0('https://api.github.com/repos/', owner, '/', repo, '/issues/', number, '/comments')
  # Body parameters
  if(is.null(body)){
    stop("Empty body in comment. Body is required field")
  }
  body_params <- list()
  body_params['body'] <- body
  # Get token
  token <- get_token()
  config <- httr::config(token=token)
  headers <- httr::add_headers(Accept = 'application/vnd.github.v3+json')
  # Try result
  result <- httr::POST(url, config = config, headers, body = body_params, encode = "json")
  result_content <- content(result, "text")
  result_list <- fromJSON(result_content)
  return(result_list)
}
