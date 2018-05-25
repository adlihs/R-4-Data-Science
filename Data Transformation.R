#Data Transformation

ipak("nycflights13")
ipak("tidyverse")

flights

#dplyr basics

#filter

filter(flights, month==1, day==1)
jan1 <- filter(flights, month==1, day==1)
dec25 <- filter(flights, month==12, day==25)

#comparisons
sqrt(2)^2 == 2
1/49 * 49 == 1

#Computers use finite precision arithmetic (they obviously can’t store an infinite number of digits!) 
#so remember that every number you see is an approximation. Instead of relying on ==, use near():

near(sqrt(2)^2,2)
near(1/49*49,1)


#Logical Operators

# & --> and
# | --> or
# ! --> not


#The following code finds all flights that departed in November or December:
filter(flights, month==1 | month ==12)

nov_dec <- filter(flights, month %in% c(11,12))

#find flights that weren’t delayed (on arrival or departure) by more than two hours, you could use either of the following two filters

filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120)

#Missing values

#if value is missing
x <- NA
is.na(x)


df <- tibble(x=c(1,x,3))
df

filter(df, x > 1)
filter(df, is.na(x) | x > 1)

#Find all flights

#1-Had an arrival delay of two or more hours

filter(flights, arr_delay >= 120)

#2- Flew to Houston (IAH or HOU)
filter(flights, dest == "IAH" | dest == "HOU")

#3- Were operated by United, American, or Delta

filter(flights, carrier %in% c("UA","AA","DL"))

#4- Departed in summer (July, August, and September)
summer <- c(7,8,9)
filter(flights, month %in% summer)

#5- Arrived more than two hours late, but didn’t leave late
filter(flights, arr_delay > 120 & dep_delay >-1)

#6- Were delayed by at least an hour, but made up over 30 minutes in flight
filter(flights, dep_delay >= 60 & air_time > 30)

#7- Departed between midnight and 6am (inclusive)
filter(flights, hour > 23 | hour <= 6)


#Arrange rows with arrange
arrange(flights, year, month, day)


#desc() to re-order by a column in descending order

arrange(flights, desc(arr_delay))


#Missing values are always sorted at the end

df <- tibble(x=c(5,2,NA))
df

arrange(df,x)
arrange(df, desc(x))

#Exercise
arrange(flights,desc(arr_delay))

arrange(flights,desc(dep_delay))

arrange(flights,air_time)
arrange(flights, desc(distance))
arrange(flights, distance)


#Select columns with select()
select(flights, year, month, day)
select(flights, year:day)
select(flights, -(year:day)) 
rename(flights, tail_num99 = tailnum)
select(flights, time_hour, air_time, everything())

#Add new variables with mutate()

flights_sml <- select(flights,
                      year:day,
                      ends_with("delay"),
                      distance,
                      air_time
  
)
mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60,
       hours = air_time / 60,
       gain_per_hour = gain / hours
       )

#If you only want to keep the new variables, use transmute():

transmute(flights,
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
  
)

#5.5.1 Useful CREATION FUNCTIONS

transmute(flights,
          dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100
  
)

#offsets
x <<- 1:10
lag(x)
lead(x)

#cumulative and rolling aggregates
x
cumsum(x)
cummean(x)

#Rank

y <- c(1,2,2,NA,3,4)
min_rank(y)
min_rank(desc(y))
row_number(y)
dense_rank(y)
percent_rank(y)
cume_dist(y)


#5.6 GROUPED SUMMARIES WITH sumarise()
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))
summarise(flights, conteo = count(flights) )

by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))


#5.6.1 COMBINING MULTIPLE OPERATIONS WITH THE PIPE

#Without pipes
by_dest <- group_by(flights, dest)
delay <- summarise(by_dest,
                   count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE)
                   )

delay <- filter(delay, count > 20, dest != "HNL")

ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)

#same but with pipes
delays <- flights %>%
  group_by(dest) %>%
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>%
  filter(count > 20, dest != "HNL")

#5.6.2 MISSING VALUES
