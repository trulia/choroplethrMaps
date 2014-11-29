#' An Administrative Level 1 map of every country in the world
#' 
#' The country is in the column "admin". The admin1 name is in the column "name".
#'  
#' @references Taken from http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-1-states-provinces/.
#' The wikipedia page on "Administrative division": http://en.wikipedia.org/wiki/Administrative_division
#' @docType data
#' @name world.admin1.df
#' @usage data(world.admin1.df)
#' @note This map is too large to efficiently render with ggplot2. You should subset it by country before
#' attempting to render. Please see the examples.
#' @examples
#' 
#' # list all countries in the map
#' unique(world.admin1.df$admin)
#' 
#' # subset the map to include only Japan - use the "admin" column for this
#' japan.df = world.admin1.df[world.admin1.df$admin == "Japan", ]
#'
#' # show the names of all admin1 units in Japan
#' unique(japan.df$name) 
#' 
#' # render the Japan map
#' ggplot(japan.df, aes(long, lat, group=group)) + geom_polygon() 
NULL

#' Render an Administrative Level 1 map for a specified country
#' 
#' Uses the map ?world.admin1.df.
#' 
#' @seealso world.admin1.df
#' 
#' @examples
#' 
#' render_admin1("Japan")
#' 
#' render_admin1("Canada")
render_admin1 = function(country.name="Japan")
{
  data(world.admin1.df, package="choroplethrMaps")
  stopifnot(country.name %in% unique(world.admin1.df$admin))
  
  country.df = world.admin1.df[world.admin1.df$admin==country.name,]
  title = paste0("Administrative Level 1 Map of ", country.name)
  ggplot(country.df, aes(long, lat, group=group)) + 
    geom_polygon() +
    ggtitle(title)
}
