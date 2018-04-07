# David R Script to take place of excel function
# Date: 04-04-2018
# Author: Jenna R. Grimshaw

# Make sure to set your working directory
# Install Package
library(dplyr)

# Imported csv file then add column names
# I named this file avan for now
# These column names are just what I came up by looking at the data
# IDK: I don't know what this is lol
colnames(avan) <- c("Family", "Start", "Stop", "TE", "size", "IDK", "Length", "IDK1", "IDK2", "IDK3")


#Total bases from file
bases <-3.91e08             # Might should script this


### Create Output DataFrame
# I named the output dataframe "ray" for now
series <- c(0:50)           # Create series 0:50 
ray<-data.frame(series)     # Convert to dataframe
ray$range <-ray$series/100  # Series/100 
ray$sum <-NA                # Sum of Lengths(?) for a given range
ray$percent<-NA             # Sum of Lengths/Total bases


# Run loop
for (i in 1:51){                       # For each number in series 0:50 (which is in rows 1:51)
  ray$sum[i] <- avan %>%               # For row i the sum column, look at the input file avan   
    filter(IDK2 == "Helitron") %>%     # Filter only the rows where column IDK2 is "Helitron"
    filter(size >= ray$range[i], size < ray$range[i+1]) %>%  #Filter again only the rows where the size falls within the range of i and i+1
    summarise(sum(Length))             # Sum the Lengths of what we have filtered and save in the sum row[i]
}                                      # Close the loop
ray$sum<-as.integer(ray$sum)           # Convert column sum from characters to integers
ray$percent <- ray$sum/bases           # Divide each sum by total number of bases

# If you haven't set your working directory yet, do so now. 
# Otherwise you might not know where R decided to save your output file.
write.csv(ray, file = "avanray.csv", row.names = FALSE) # Save output file as .csv. 

