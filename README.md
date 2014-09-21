This markdown file to describe the analysis for run_analysis.R

The script begins by first reading in all of the variables stored in the "features.txt" data file. This is a character vector containing the names of the variables, and saving it to a matrix "Variables".

After that, the script then proceeds to read in the labels for the different activities (running, walking, etc...).  Again, the result is a one-dimensional character matrix saved as "Activities"

The script then reads in the three data files for the Test subset. These files contain the IDs of the individuals participating, the number identifying the activity, and the number identifying the variable. As the variables are being read in, they are then converted to their respective character description. The same is then done for the activities. The end result is a data set for all of the Test data listing the person ID, a character description of the activity, and all of the data, with a character description of each one. A column vector identifying all of this data as being part of the Test group is then added to the data set by means of a column bind and called "TestTotal"

This process is then repeated for the Train data set, resulting in a dataset "TrainTotal".  Afterwhich, the two data sets are then combined into a single, all-encompassing data set by means of a row bind to make "CombinedData"

A column vector ("MeansSDs") is then created to identify the sets of data that correspond to just the means and standard deviations. Those values are then subsetted from the "CombinedData" set to yield just the desired set of data with means and standard deviations, "RefinedData"
