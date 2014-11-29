if (base::getRversion() >= "2.15.1") {
  utils::globalVariables(c("long", "lat", "group", "admin1.map", "admin1.regions"))
}
#' An Administrative Level 1 map of every country in the world
#' 
#' The country is in the column "admin". The admin1 region name is in the column "name".
#'  
#' @references Taken from http://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-1-states-provinces/.
#' The wikipedia page on "Administrative division": http://en.wikipedia.org/wiki/Administrative_division
#' @docType data
#' @name admin1.map
#' @usage data(admin1.map)
#' @note This map is too large to efficiently render with ggplot2. You should subset it by country before
#' attempting to render. Please see the examples.
#' @examples
#' 
#' \dontrun{
#' library(ggplot2)
#' data(admin1.map)
#' 
#' # list all countries in the map
#' unique(admin1.map$admin)
#' 
#' # subset the map to include only Japan - use the "admin" column for this
#' japan.map = admin1.map[admin1.map$admin == "Japan", ]
#'
#' # show the names of all admin1 units in Japan
#' unique(japan.map$name) 
#' 
#' # render the Japan map
#' ggplot(japan.map, aes(long, lat, group=group)) + geom_polygon() 
#' }
NULL

#' Names of all (country, admin1) pairs on the admin1.map data.frame. 
#' @name admin1.regions
#' @usage data(admin1.regions)
#' @docType data
#' @examples
#' data(admin1.regions)
#' head(admin1.regions)
NULL

#' Render an Administrative Level 1 map for a specified country
#' 
#' Uses the map ?admin1.map.
#' 
#' @param country.name The name of the country you want to render.  
#' @seealso admin1.map
#' 
#' @examples
#' 
#' \dontrun{
#' render_admin1("Japan")
#' 
#' render_admin1("Canada")
#' }
#' @importFrom ggplot2 ggplot aes geom_polygon ggtitle
#' @export
render_admin1 = function(country.name="Japan")
{
  data(admin1.map, package="choroplethrMaps", envir=environment())
  stopifnot(country.name %in% unique(admin1.map$admin))
  
  country.map = admin1.map[admin1.map$admin==country.name,]
  title = paste0("Administrative Level 1 Map of ", country.name)
  ggplot(country.map, aes(long, lat, group=group)) + 
    geom_polygon() +
    ggtitle(title)
}

#' Get all admin1 regions names for a given country
#' 
#' @param country.name The name of the country you want the admin1 region names of.
#' @export
#' @examples
#' get_admin1_regions("Japan")
#' get_admin1_regions("Canada")
#' @seealso admin1.map admin1.regions render_admin1
get_admin1_regions = function(country.name="Japan")
{
  data(admin1.regions, package="choroplethrMaps", envir=environment())
  stopifnot(country.name %in% unique(admin1.regions$country))
  
  admin1.regions[admin1.regions$country==country.name,]  
}
