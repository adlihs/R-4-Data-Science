#Data visualisation

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