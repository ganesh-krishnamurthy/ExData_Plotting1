########################################################
## plot1.R - This program produces "Plot 1" (a histogram of golabl active #
## power). The first step reads in the raw file 'household_power_consumption.txt' #
## and subsets it for 2 specific days. #
## Author: Ganesh Krishnamurthy #
## Creation date: 07/10/2015 #
########################################################

#########################################################
## A function to read-in the household_power_consumption.txt file, perform some date #
## calculations and subset the observations to only 2007-02-01 and 2007-02-02. This function #
## will be re-used/called in plot2.R, plot3.R and plot4.R. This (write once - use many times) #
## is good programming practice, instead of defining the 'file read' in each of the four #
## (plo1--plot4) R program files. #
#########################################################
readElectricityFile<-function(fileName)
{
    ########################################################
    ## Step 1: Read in the raw file containing electricity meter readings #
    ########################################################
    
    # To make the file read faster, read the first 10 records and identify the 
    # class of each column. Note: Since the Date and Time columns seems to get read-in as "factors", 
    # convert them to character using stringAsFactors=FALSE
    top10<-read.table(fileName,header=TRUE, sep=";", nrows=11, stringsAsFactors = FALSE)
    
    classes<-sapply(top10, class)
    
    # Now read-in the full file using the classes created above as an input to colClasses. 
    # Also, specify the numbers of rows to read as 2,075,259 
    fullFile<-read.table(fileName, header=TRUE, sep=";", nrows=2075259, colClasses=classes, na.strings="?")
    
    ########################################################
    ## Step 2: Convert the date and time fields into proper formats. They were read-in as 
    ## character. Combine into a single field "dateTime" and then using strptime() 
    ########################################################
    fullFile$DateTime<-paste(fullFile$Date, fullFile$Time)
    
    fullFile$DateTime<-strptime(fullFile$DateTime, "%d/%m/%Y %H:%M:%S")
    
    ########################################################
    ## Step 3: Subset the records to only 2007-02-01 and 2007-02-02 #
    ########################################################
    d_range<-c("2007-02-01", "2007-02-02")
    expl_DF<-fullFile[as.Date(fullFile$DateTime) %in% as.Date(d_range),]
    
    # Return the data frame. Also, release memory
    rm(fullFile)
    return(expl_DF)
}

#########################################################################
## Plot_1: This function does the actual plotting of the histogram #
#########################################################################
plot1<-function()
{
    # A. Read-in the household_power_consumption.txt file and subset it to just 2 days 
    # (Feb 1, 2 in 2007) using the readElectricityFile() function defined above.
    elec_DF<-readElectricityFile(fileName="household_power_consumption.txt")
    
    # B. Generate the plot
    with(elec_DF, hist(x=Global_active_power, col="red", xlab="Global Active Power (kilowatts)",
         main="Global Active Power"))
    
    # C. Save the plot to a PNG file
    dev.copy(png, "plot1.png")
    dev.off()
}


