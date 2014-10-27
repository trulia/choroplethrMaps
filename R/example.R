print_country = function(country.name="Japan")
{
  data(world.admin1.df)
  country.df = world.admin1.df[world.admin1.df$admin==country.name,]
  ggplot(country.df, aes(long, lat, group=group)) + geom_polygon() 
}

