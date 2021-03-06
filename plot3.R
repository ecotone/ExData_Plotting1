## plot3.R
##   This script is part of Week 1 assignment for
##   coursera / John Hopkins University's  
##   'Exploratory Data Analysis' class
##   Instructors: Roger D. Peng, Jeff Leek and Brian Caffo
##
##   Please stop reading if you haven't completed this assignment.
##
## Purpose of script: 
##     Creates plot3.png to current work directory
## Prerequisites (Script assummes that...):
##     ...the 'household_power_consumption.txt' file, as unzipped from the
##        assignment's input file is in current work directory.
##     ...the 'load_data.R' file is in current work directory.
##
## author: mjv
## date  : 5/8/2014
##

source("load_data.R")

# *** Assert underlying data (epc) is readily available, or load it if need be
# Note: The Input data file is assumed to be in current directory, under this name;
# You can change as needed if you have the file in another directory or under a
# different name.
# Alternatively you can use the path + file Name to a ZIP archive containing the
# data file; such an archive should have its extension be '.zip' and have the data
# file as its first/sole contained file. (just like the archive supplied for the
# assignment)
epc.fileName <- "./household_power_consumption.txt"
GetElectricPowerConsumptionData(epc.fileName)

# *** Produce the required plot in a png file
png(file="Plot3.png")
plot(epc$DateTime, epc$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
lines(epc$DateTime, epc$Sub_metering_1, col="black")
lines(epc$DateTime, epc$Sub_metering_2, col="red")
lines(epc$DateTime, epc$Sub_metering_3, col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
