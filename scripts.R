#Data visualisation
#Cheat sheets: https://www.rstudio.com/resources/cheatsheets/
#ggplot extensions: http://www.ggplot2-exts.org/gallery/

ipak('tidyverse')

#MPG Data Frame
mpg
   
#Creating a ggplot

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y= hwy))

#A graphing template
#ggplot(data= <DATA>) +
  #<GEOM_FUNCTION>(mapping= aes(x=DATA.VAR, y=DATA.VAR))


#Exercises

ggplot(data = mpg)

ggplot(data = mpg) +
  geom_point(mapping = aes(x=hwy, y=cyl))

ggplot(data = mpg) +
  geom_point(mapping = aes(x=class, y=drv))


#Aesthetic mappings

#Color
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, color = class))

#Size
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, size = class))

#Transparency
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, alpha = class))

#Shape
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, shape=class))


#All aesthetic points in blue
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy),color = "blue")

#Facets

#Facet wrap
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy)) +
  facet_wrap(~ class, nrow = 2)

#Facet grid
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  facet_grid(drv~cyl)


#Geometric objects

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x=displ, y = hwy, group = drv))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv), show.legend = TRUE)

#Multiple geoms in the same plot
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y =hwy)) +
  geom_smooth(mapping = aes(x = displ, y=hwy))


#Multiple geoms in the same plot - less lines
ggplot(data = mpg, mapping = aes(x= displ, y = hwy)) +
  geom_point() +
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth()


ggplot(data = mpg, mapping = aes(x=displ, y= hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)



ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  geom_smooth(mapping = aes(x=displ, y = hwy), se = FALSE)

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy)) +
  geom_smooth(mapping = aes(x=displ, y = hwy, group = drv), se = FALSE)


ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy, color = drv)) +
  geom_smooth(mapping = aes(x=displ, y = hwy, group = drv), se = FALSE)

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy, color = drv)) +
  geom_smooth(mapping = aes(x=displ, y = hwy, color = drv, group = drv), se = FALSE)

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy, color = drv)) +
  geom_smooth(mapping = aes(x=displ, y = hwy), se = FALSE)

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy, color = drv)) +
  geom_smooth(mapping = aes(x=displ, y = hwy, linetype = drv), se = FALSE)

#Statistical transformations
#Bar plots
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x=cut))

#Bar plot using stat_count() instead of geom_bar()
ggplot(data = diamonds) +
  stat_count(mapping = aes(x = cut))


#Bar plot overwriting stat_count with stat_identity

demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)

ggplot(data = demo) +
  geom_bar(mapping = aes(x=cut,y=freq), stat = "identity")

#display a bar chart of proportion, rather than count
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y= ..prop.., group = 1))

ggplot(data = diamonds) +
  stat_summary(
    mapping = aes(x=cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

#Position adjustments
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x=cut, color = cut))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x=cut, fill = cut))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x=cut, fill = clarity))

#POSITION = IDENTITY

ggplot(data = diamonds, mapping = aes(x= cut, fill = clarity)) +
  geom_bar(alpha = 1/5, position = "identity")
