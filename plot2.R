#####################################################################
## plot2.R - This program creates a line chart to show Global active power usage against #
## time. The data is read-in from the household_power_consumption.txt file using the #
## readElectricityFile() function defined in plot1.R (the plot1.R program is sourced here). #
## The line plot is created in 2 steps: Create the plot with type="n" option and in #
## next step, the lines are drawn. #
## Author: Ganesh Krishnamurthy #
## Creation date: 07/10/2015 #
## Dependencies: plot1.R #
#####################################################################

# Source the program containing code for reading in the household power consumption text file
source("plot1.R")

###################################################
# plot2 - The function to plot the time series of Global Active Power
###################################################
plot2<-function()
{
    #####################################################################
    # Step 0: Read in the household_power_consumption.txt by reusing a function written in 
    # plot1.R. The function reads in the full file, subsets it for 2 days and creates a new variable
    # 'DateTime' using the Date and Time columns. For more details, please refer definition/body of 
    # readElectricityFile() function in plot1.R 
    #####################################################################
    elec_DF<-readElectricityFile(fileName="household_power_consumption.txt")
    
    #####################################################################
    # Step 1: Draw the line plot 
    #####################################################################
    
    # Create an empty plot frame
    with(elec_DF, plot(x=DateTime, y=Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)"))
    # Add the time series line
    with(elec_DF, lines(x=DateTime, y=Global_active_power))
    
    #####################################################################
    # Step 2: Save to a PNG file
    #####################################################################
    dev.copy(png, "plot2.png")
    dev.off()
}