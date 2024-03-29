% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/endPoint.R
\name{endPoint}
\alias{endPoint}
\title{Detects when the laser ablates through the target sample in a laser ablation mass spectrometry time resolved analysis.}
\usage{
endPoint(
  detectDf,
  dt = 10,
  smoothing = 5,
  timeCol = "Time",
  signalCol = "Ca44",
  profile = "FLASE",
  timeUnits = "seconds"
)
}
\arguments{
\item{detectDf}{A data frame containing a single time resolved analysis, with a column referencing time and another with the corresponding measured counts data.}

\item{dt}{An integer that controls the number of observations (rows) are used in calculating a rolling lagged difference in 44Ca signal. Using a lower value for a faster ablation through of chamber wall can improve end point sensitivity. Default = 10.}

\item{smoothing}{Controls the length of the moving average filter to apply over the dt period. Default = 5.}

\item{timeCol}{The column title in the data frame identifying the time stamp of the time resolved analysis. Default = "Time".}

\item{signalCol}{The column title in the data frame identifying the numerical data used to identify the laser ablation blast through endpoint. This is often 44Ca but could be any column of numerical data that you want to detect the endpoint. Default = "Ca44".}

\item{profile}{Logical. A visualisation of the endpoint detection mechanism as a ggplot2 object. To make this profile plot, set the argument to TRUE, otherwise set it to FALSE. Specifying to not make a plot can save a substantial amount of time. Default = "FALSE".}

\item{timeUnits}{The units that the time resolved analysis is measured in. This is the units of the timeCol. This argument is a string and is only necessary if the argument profile = "TRUE". Default = "seconds".}
}
\value{
The function returns a data frame containing the columns:
\itemize{
\item dfReturn$detectDf contains a data frame with only the observations between the first data frame row and the endTime.
\item dfReturn$startTime contains the earliest time in your TRA as a numerical value.
\item df$Return$endTime contains the last time step while the laser is still focussed the desired target in your TRA before the as a numerical value.
\item df$Return$profile contains a visualisation of your TRA identifying where the laser ablated through the carbonate shell as a ggplot object. This is only available if a profile was generated using profile = "TRUE".
}
}
\description{
This function imports a data frame containing a single time resolved laser ablation mass spectrometry analysis of a foraminifera (or other carbonate shell).
It assumes that the first row contains the signal of the target sample and that background correction has already been applied.
\cr
Column names referencing the time stamps and target signal are specified as function arguments.
Then the signal column is evaluated by smoothing the values using a moving average, then scaled between 0-1 and the rate of change over a number of observations.
\cr
The function identifies the maximum rate of signal change, locates the corresponding time stamp and then subtracts the time it took for the laser to ablate through the target.
The result (endTime) is the time stamp of the last observation while the laser is still focussed the desired target.
}
\examples{
endPoint(detectDf = foram72shot3, dt = 10, smoothing = 5, timeCol = "Time",
 signalCol = "Ca44", profile = "TRUE",  timeUnits = "seconds")
endPoint(detectDf = foram166shot7, dt = 8, smoothing = 7, timeCol = "Time",
 signalCol = "Ca44", profile = "FALSE",  timeUnits = "seconds")
endPoint(detectDf = foram174shot4, dt = 10, smoothing = 5, timeCol = "Time",
 signalCol = "Ca43", profile = "TRUE",  timeUnits = "seconds")
endPoint(detectDf = coral6, dt = 10, smoothing = 5, timeCol = "Time",
 signalCol = "Sr86", profile = "FALSE",  timeUnits = "milliseconds")
}
