library(leaflet)
suppressPackageStartupMessages(library(lubridate))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(tidyverse))

# read data
mydata <- read.csv("data/nez-opendata_02_19.csv", 
                   na.strings = c("","NA"),
                   stringsAsFactor = FALSE) 
dim(mydata)
# have a look at the first few rows
head(mydata)

# note that the variables are not named.
# name the variables
names(mydata) <- letters[1:7]
head(mydata)
str(mydata)
glimpse(mydata)

# separate date and time and save as two variables ('date' and 'time')
mydata <- separate(mydata, b, c("date", "time"), sep = ",")
glimpse(mydata)

summary(mydata)

# organise data: format as factors e, d and f columns 
cols <- c("e", "f", "g")
mydata[cols] <- lapply(mydata[cols], as.factor)
glimpse(mydata)
summary(mydata)

# format data and time columns
mydata$date <- format(as.POSIXct(mydata$date,format="%d.%m.%Y"),"%d/%m/%Y")
mydata$time <- format(as.POSIXct(mydata$time, format="%H:%M"),"%H:%M")
mydata$date <- as.Date(mydata$date, "%d/%m/%Y")
glimpse(mydata)

# change the names of the levels in the factor variable e
summary(mydata$e)
levels(mydata$e) <- c("material_demage", "deaths", "injured")
glimpse(mydata)

# change the names of the levels in the factor variable e
summary(mydata$f)
levels(mydata$f) <- c("one_vehicle", "two_vehicle_no_turn", "two_vehicle", "parked_vehicle", "pedestrian")
glimpse(mydata)

# rename the variables
mydata <- rename(mydata, id = a, long = c, lat = d, accident = e, type_acc = f, descrip = g)
glimpse(mydata)