#' List Columns in a Project
#' @param owner The owner of the repository. In a repo name, it would be the part before the slash.
#' @param repo The name of the repository
#' @param state The state of the milestone. Either open, closed, or all.
#' @param sort What to sort results by. Either due_on or completeness.
#' @param direction The direction of the sort. Either asc or desc.
#' @importFrom httr config add_headers GET
#' @export
list_milestones <- function(owner, repo, state='open', sort='due_on', direction='asc'){
  url <- paste0('https://api.github.com/repos/', owner, '/', repo, '/milestones?state=',
                state, '&sort=', sort, '&direction=', direction)
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

#' Get Project details
#' @param owner The owner of the repository. In a repo name, it would be the part before the slash.
#' @param repo The name of the repository
#' @importFrom httr config add_headers GET
#' @export
get_milestone <- function(owner, repo, milestone_id){
  url <- paste0('https://api.github.com/repos/', owner, '/', repo, '/milestones/', milestone_id)
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
