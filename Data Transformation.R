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
