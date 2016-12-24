.onAttach <- function(libname, pkgname) {
  packageStartupMessage("Please use predefined Credentials only for the testing requests. To obtain your own Credentials see help(authorize).")
}

.onLoad <- function(libname, pkgname) {
  op <- options()
  op.slides <- list(
    github.client.id = "64f0ca002374f3ec632d",
    github.client.secret = "eeff4397fdbe152142c5673239d74f855db05243",
    github.endpoint.get = "https://slides.googleapis.com/v1/presentations/{presentationId}"
  )
  toset <- !(names(op.slides) %in% names(op))
  if (any(toset)) options(op.slides[toset])

  invisible()
}
