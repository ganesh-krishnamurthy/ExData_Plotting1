###########################################################################
## plot4.R - This program plots 4 charts in a 2 by 2 format using the par(mfrow=c(2,2)) option. #
## The data is read (& subsetted for 2 days) from the household_power_consumption.txt file using the #
## readElectricityFile() function written in plot1.R. #
## Author: Ganesh Krishnamurthy #
## Creation date: 07/10/2015 #
###########################################################################

# Step 0: Source the plot1.R file to get the function definition of readElectricityFile()
source("Plot1.R")

##################################################
## plot4 - A function to create the 4 plots arranged in a specific order #
##################################################
plot4<-function()
{
    ########################################
    # Step 1: Read in the data, create a DateTime column and subset for 2007-02-01 and 2007-02-02.
    # Re-use the readElectricityFile() function written in plot1.R
    ########################################
    elec_DF<-readElectricityFile(fileName="household_power_consumption.txt")
    
    ########################################
    # Step 2: Set the plotting grid as 2-by-2
    ########################################
    par(mfrow=c(2,2))
    
    ########################################
    # Step 3: Create the plots in required order
    ########################################
    
    # A. Time series of Global active power
    with(elec_DF, 
         {
           plot(x=DateTime, y=Global_active_power, type="n", xlab="", ylab="Global Active Power")
           lines(x=DateTime, y=Global_active_power)
         }
    )
    
    # B. Time series of Voltage
    with(elec_DF,
         {
           plot(x=DateTime, y=Voltage, type="n", xlab="datetime", ylab="Voltage")
           lines(x=DateTime, y=Voltage)
         }
    )
    
    # C. Time series of sub_metering 1, 2 and 3 with color legend
    with(elec_DF,
         {
           plot(x=DateTime, y=Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
           lines(x=DateTime, y=Sub_metering_1)
           lines(x=DateTime, y=Sub_metering_2, col="red")
           lines(x=DateTime, y=Sub_metering_3, col="blue")
           legend("topright", pch="_____", cex=0.8, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
         }
    )
    
    # D. Time series of Global Reactive power
    with(elec_DF,
         {
           plot(x=DateTime, y=Global_reactive_power, type="n", xlab="datetime")
           lines(x=DateTime, y=Global_reactive_power)
         }
    )
    
    ###############################################
    ## Step 4: Create a PNG file #
    ###############################################
    dev.copy(png,"plot4.png")
    dev.off()
    
    # Set the graphics paramater back to normal
    par(mfrow=c(1,1))
}