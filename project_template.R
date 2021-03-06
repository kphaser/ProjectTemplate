## Getting started with ProjectTemplate in R/RStudio

# get ProjectTemplate up and running
install.packages("ProjectTemplate")
library("ProjectTemplate")

# this command will generate a directory called 'letters'
create.project('letters') # download at http://projecttemplate.net/letters.csv.bz2

# make sure to copy the data file (letters.csv.bz2) into the data subdirectory generated by create.project()

# set the working directory to the project and load
setwd("letters/")
load.project() # letters data will be automatically loaded

# examine the loaded data
head(letters)

# you can automate package loading by editing the 'config/global.dcf' file
# adjust these settings:
#
# load_libraries: TRUE
# libraries: reshape, plyr, ggplot2, stringr, lubridate

# if you want to compute aggregates, we can automate this as part of the preprocessing step when load.project()
# takes place by editing the 'munge/01-A.R' script:
#
# first.letter.counts <- ddply(letters, c('FirstLetter'), nrow)
# second.letter.counts <- ddply(letters, c('SecondLetter'), nrow)

# reload the project with edits
library("ProjectTemplate")
load.project()

# ddply() computations can be long even with simple output. we can cache the output rather than running it each time
cache("first.letter.counts")
cache("second.letter.counts")

# re run the project again to see
library("ProjectTemplate")
system.time(load.project()) # it's much faster after caching

# if you have cache objects, you can turn off munging in the 'config/global.dcf' file to speed things up
# munging: FALSE
library("ProjectTemplate")
system.time(load.project()) # about 3x faster

# do whatever you want to the data now
plot1 <- ggplot(first.letter.counts, aes(x=V1)) + geom_density()
plot1
ggsave(file.path("graphs","plot1.pdf"))

plot2 <- ggplot(second.letter.counts, aes(x=V1)) + geom_density()
plot2
ggsave(file.path("graphs","plot2.pdf"))