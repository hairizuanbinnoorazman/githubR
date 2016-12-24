#' List Issues in a Repository
#' @param owner The owner of the repository. In a repo name, it would be the part before the slash.
#' @param repo The name of the repository
#' @param milestone If an integer is passed, it should refer to a milestone by its number field.
#' If the string * is passed, issues with any milestone are accepted. If the string none is passed,
#' issues without milestones are returned.
#' @param state The state of the milestone. Either open, closed, or all.
#' @param assignee Can be the name of a user. Pass in none for issues
#' with no assigned user, and * for issues assigned to any user.
#' @param creator The user that created the issue.
#' @param mentioned A user that's mentioned in the issue.
#' @param labels A list of comma separated label names. Example: bug,ui,@high
#' @param sort What to sort results by. Can be either created, updated, comments. Default: created
#' @param direction The direction of the sort. Either asc or desc.
#' @param since Only issues updated at or after this time are returned. Format is YYYY-MM-DD
#' @importFrom httr config add_headers GET
#' @export
list_repo_issues <- function(owner, repo, milestone = '*', state='open',
                             assignee = '*', creator = NULL, mentioned = NULL,
                             labels = NULL, sort='created', direction='asc', since = NULL){
  url <- paste0('https://api.github.com/repos/', owner, '/', repo, '/issues?',
                'milestone=', milestone, '&state=', state,
                '&assignee=', assignee, '&sort=', sort, '&direction=', direction)
  if(!is.null(creator)){url <- paste0(url, '&creator=', creator)}
  if(!is.null(mentioned)){url <- paste0(url, '&mentioned=', mentioned)}
  if(!is.null(labels)){url <- paste0(url, '&labels=', labels)}
  if(!is.null(since)){url <- paste0(url, '&since=', paste(as.Date(since), 'T00:00:00Z'))}
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
