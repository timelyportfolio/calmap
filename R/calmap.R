#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
calmap <- function(
  data = NULL,
  facet = FALSE,
  ...,
  width = NULL, height = NULL,
  elementId = NULL
) {

  # forward options using x
  x = list(
    data = data,
    facet = facet,
    ...
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'calmap',
    x = x,
    width = width,
    height = height,
    package = 'calmap',
    elementId = elementId
  )
}

#' Shiny bindings for calmap
#'
#' Output and render functions for using calmap within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a calmap
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name calmap-shiny
#'
#' @export
calmapOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'calmap', width, height, package = 'calmap')
}

#' @rdname calmap-shiny
#' @export
renderCalmap <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, calmapOutput, env, quoted = TRUE)
}

#' @keywords internal
calmap_html <- function(id, style, class, ...){
  htmltools::attachDependencies(
    htmltools::tagList(
      htmltools::tags$div(id=id, style=style, class=class, ...)
    ),
    d3r::d3_dep_v4()
  )
}
