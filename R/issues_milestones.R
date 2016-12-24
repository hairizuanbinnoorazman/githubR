#' List Milestones in a Repository
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

#' Get Milestone details
#' @param owner The owner of the repository. In a repo name, it would be the part before the slash.
#' @param repo The name of the repository
#' @param milestone_id The milestone_id of the milestone
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

#' Create milestone
#' @param owner The owner of the repository. In a repo name, it would be the part before the slash.
#' @param repo The name of the repository
#' @param title Required. The title of the milestone.
#' @param description A description of the milestone.
#' @param state The state of the milestone. Either open or closed.
#' @param due_on A date in YYYY-MM-DD format
#' @importFrom httr config add_headers GET
#' @export
create_milestone <- function(owner, repo, title=NULL, description=NULL, state=NULL, due_on=NULL){
  url <- paste0('https://api.github.com/repos/', owner, '/', repo, '/milestones')

  # Get token
  token <- get_token()
  config <- httr::config(token=token)
  headers <- httr::add_headers(Accept = 'application/vnd.github.v3+json')
  # Wrapping body parameters in a requests list
  body_params <- list()
  if(!is.null(title)){
    body_params[['title']] <- title
  } else {
    return(list(status = 'failed', error = 'Title is a required field'))
  }
  if(!is.null(description)){body_params[['description']] <- description}
  if(!is.null(state)){body_params[['state']] <- state}
  print('miao')
  if(!is.null(due_on)){body_params[['due_on']] <- paste0(as.Date(due_on), 'T12:00:00Z')}

  # Try result
  result <- httr::POST(url, config = config, headers, body = body_params, encode = "json")
  result_content <- content(result, "text")
  result_list <- fromJSON(result_content)
  return(result_list)
}
