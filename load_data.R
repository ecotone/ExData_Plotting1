## load_data.R
##   This script is part of Week 1 assignment for
##   coursera / John Hopkins University's  
##   'Exploratory Data Analysis' class
##   Instructors: Roger D. Peng, Jeff Leek and Brian Caffo
##
##   Please stop reading if you haven't completed this assignment.
##
## Purpose of script: 
##     loads and subsets the data relevant to the rest of the assignment 
##
## author: mjv
## date  : 5/8/2014
##


## GetElectricPowerConsumptionData()
##  This function loads the data relevant to the rest of the assignment, into
##  the epc variable
##  Arguments:
##   fileName = (character) name and optional path to the input data file
##     this can either be the text file (originally named 'household_power_consumption.txt')
##     or the zipped file containing it.
##     If the fileName supplied ends in ".zip", the file is exacted from this archive;
##     the data file is then assumed to be the first file in the archive.
##   noCache = (logical) Use TRUE to force this function to reload the data from the file;
##             When FALSE, and if the global variable named 'epc' exists, no actual
##             work is done.  This allows all the plot-creating functions to systematically
##             invoke this function, without encurring the cost of actually loading the data
##             anew each time.
##  Return Value: 
##    TRUE if all is OK;  the data relevant to the assignment can be found in 'epc' global variable
##    FALSE in case of error.  In such case, error messages are printed to the screen, for
##    diagnostics purposes etc..
GetElectricPowerConsumptionData <- function(fileName, noCache=FALSE) {
    # *** destroy epc globabl variable if "noCache" is requested (and if it readily exists)
    if (noCache &  !is.null(.GlobalEnv$epc)) {
        rm("epc", envir=globalenv())
    }
    
    # *** We only create 'epc' global variable, if we don't already have it
    if (is.null(.GlobalEnv$epc)) {
        
        # When ZIP file provided: we first unzip it (to current working dir)...
        if (length(grep("\\.zip$", fileName, ignore.case=TRUE)) == 1) {
            unzippedFileNames <- unzip(fileName)
            fileName <- unzippedFileNames[1]
            delInputFileWhenDone <- TRUE    #... and we take not to later delete it
        }
        else {
            delInputFileWhenDone <- FALSE
        }
        
        # load and convert data
        # Note that we convert _before_ subsetting, which is inefficient but more
        # generic, would we want to observe other data in epc.all etc.
        epc.all <- read.csv(fileName, sep=";", na.strings="?", stringsAsFactors=FALSE)
        epc.all$DateTime <-strptime(paste(epc.all$Date, epc.all$Time), format="%d/%m/%Y %H:%M:%S")
        epc.all$Date <- as.Date(epc.all$Date, format="%d/%m/%Y")
        
        # The data for the assignment only includes two days' worth of recording
        assign("epc", epc.all[epc.all$Date == "2007-02-01" | epc.all$Date == "2007-02-02",],
               envir=.GlobalEnv)
        
        # clean-up the data file, if it was provided in a zip archive.
        if (delInputFileWhenDone) {
            unlink(fileName)
        }
    }
    
    # very basic assertion that epc is ok: we must have exactly 2 dates since that
    # is how we built it.
    # Returns TRUE when epc is a-priori ok.
    length(table(.GlobalEnv$epc$Date)) == 2
}