% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/datasets_erddap.R
\docType{data}
\name{cciea_EI_FBN}
\alias{cciea_EI_FBN}
\title{Forage Biomass, California Current North}
\format{
A data frame with 238 rows and 5 variables:
\describe{
\item{time}{Time (seconds since 1970-01-01T00:00:00Z) [8.836128E8, 1.5463008E9]}
\item{species_group}{Species Group () []}
\item{mean_density}{Mean Density (Linear density (Log10(no. km-1+ 1)).) [0.0, 1.9612]}
\item{Seup}{Confidence Interval, Upper () [0.0, 2.099]}
\item{Selo}{Confidence Interval, Lower () [-4.1E-4, 1.824]}
}
}
\source{
\url{https://oceanview.pfeg.noaa.gov/erddap/info/cciea_EI_FBN/index.html}
}
\usage{
cciea_EI_FBN
}
\description{
Source Data: Dr. Brian Burke (NOAA; brian.burke@noaa.gov); derived from surface trawls taken during NOAA Northwest Fisheries Science Center Juvenile Salmon & Ocean Ecosystem Survey (JSOES).  Additional calculations by Cheryl Morgan (OSU - CIMRS; cheryl.morgan@oregonstate.edu). Partial funding is from the Bonneville Power Administration (1998-014-00). Additional Calculations: Jellyfish data from 1998 were not reliably recorded and are not included in this analysis. To be included in this analysis, stations must have been 1) sampled during the day time, 2) on the continental shelf (greater than 200 m water depth), and 3) sampled during at least half of the years of the JSOES effort. Sampling occurs from the northern tip of Washington (48N 13.7') down to Newport, Oregon (44N 40.0') in late June. A Nordic 264 rope trawl (Nor'Eastern Trawl Systems, Bainbridge Island, WA) is towed at the surface (upper 20 m) for 15 - 30 min at approximately 6.5 km/hr. The total abundance for each nekton species caught in each haul was either determined directly or estimated from the total weight of the species in a catch and the weight and number of individuals in a subsample of that catch.  Trawl catches were standardized to linear density by dividing catch of each species at a station by the distance between the start- and endpoints of the tow as determined by a global positioning system receiver and log10 transformed (Log10(no. km-1+ 1)).
}
\concept{dataset_erddap}
\keyword{datasets}
