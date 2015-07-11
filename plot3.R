#####################################################################
## plot3.R - This program creates a line chart to show time series of 3 variables (sub metering 1,2,3). #
## The data is read-in from the household_power_consumption.txt file using the #
## readElectricityFile() function defined in plot1.R (the plot1.R program is sourced here). #
## Author: Ganesh Krishnamurthy #
## Creation date: 07/10/2015 #
## Dependencies: plot1.R #
#####################################################################

# Source the program containing code for reading in the household power consumption text file
source("plot1.R")

###################################################
# plot3 - The function to plot the time series of sub metering 1, 2 and 3
###################################################
plot3<-function()
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
  
  # Create an empty plot frame (using type="n") and then add the 3 time series with different colors
  # Add a legend in teh top-right position
  with(elec_DF,
       {
         plot(x=DateTime, y=Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
         lines(x=DateTime, y=Sub_metering_1)
         lines(x=DateTime, y=Sub_metering_2, col="red")
         lines(x=DateTime, y=Sub_metering_3, col="blue")
         legend("topright", pch="_____", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
       }
      )
  
  #####################################################################
  # Step 2: Save to a PNG file
  #####################################################################
  dev.copy(png, "plot3.png")
  dev.off()
}