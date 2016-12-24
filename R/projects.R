#' List Projects on a repository on Github
#' @importFrom httr config add_headers GET
#' @export
list_repo_projects <- function(owner, repo){
  url <- paste0('https://api.github.com/repos/', owner, '/', repo, '/projects')
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

#' List Projects in a organization on Github
#' @importFrom httr config add_headers GET
#' @export
list_org_projects <- function(org){
  url <- paste0('https://api.github.com/orgs/', org, '/projects')
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

#' Get Project details
#' @importFrom httr config add_headers GET
#' @export
get_project <- function(project_id){
  url <- paste0('https://api.github.com/projects/', project_id)
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

#' Create a Project in a repository
#' @importFrom httr config add_headers GET
#' @export
create_repo_project <- function(owner, repo, project_name, project_desc){
  url <- paste0('https://api.github.com/repos/', owner, '/', repo, '/projects')
  # Get token
  token <- get_token()
  config <- httr::config(token=token)
  headers <- httr::add_headers(Accept = 'application/vnd.github.inertia-preview+json')
  # Wrapping body parameters in a requests list
  body_params <- list(name = project_name, body = project_desc)
  # Try result
  result <- httr::POST(url, config = config, headers, body = body_params, encode = "json")
  result_content <- content(result, "text")
  result_list <- fromJSON(result_content)
  return(result_list)
}

#' Create a Project in a organization
#' @importFrom httr config add_headers GET
#' @export
create_org_project <- function(org, project_name, project_desc){
  url <- paste0('https://api.github.com/orgs/', org, '/projects')
  # Get token
  token <- get_token()
  config <- httr::config(token=token)
  headers <- httr::add_headers(Accept = 'application/vnd.github.inertia-preview+json')
  # Wrapping body parameters in a requests list
  body_params <- list(name = project_name, body = project_desc)
  # Try result
  result <- httr::POST(url, config = config, headers, body = body_params, encode = "json")
  result_content <- content(result, "text")
  result_list <- fromJSON(result_content)
  return(result_list)
}



