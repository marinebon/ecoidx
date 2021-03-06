% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/datasets_erddap.R
\docType{data}
\name{cciea_B_AS_DENS}
\alias{cciea_B_AS_DENS}
\title{Seabird at-sea density anomaly}
\format{
A data frame with 222 rows and 3 variables:
\describe{
\item{time}{Time (seconds since 1970-01-01T00:00:00Z) [5.364576E8, 1.5463008E9]}
\item{density_anomaly}{Density Anomaly () [-2.107251, 1.742638]}
\item{species_cohort}{Species (season) () []}
}
}
\source{
\url{https://oceanview.pfeg.noaa.gov/erddap/info/cciea_B_AS_DENS/index.html}
}
\usage{
cciea_B_AS_DENS
}
\description{
Data are shipboard counts, transformed as ln(bird density/km2 +1) and expressed as an anomaly of log density relative to the long-term mean. So CC: Data are from CalCOFI surveys (http://calcofi.org/field-work/underway-observations/380-bird-observations.html), courtesy of Dr. Bill Sydeman of the Farallon Institute (wsydeman@faralloninstitute.org). Ce CC: Data are from the SWFSC Rockfish Recruitment and Ecosystem Assessment Survey (https://swfsc.noaa.gov/textblock.aspx?Division=FED&ParentMenuId=54&id=20615). No CC: Data are shipboard counts, transformed as ln(bird density/km2 +1) and expressed as an anomaly of log density relative to the long-term mean.
}
\concept{dataset_erddap}
\keyword{datasets}
