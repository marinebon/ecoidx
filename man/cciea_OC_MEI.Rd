% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/datasets_erddap.R
\docType{data}
\name{cciea_OC_MEI}
\alias{cciea_OC_MEI}
\title{Multivariate ENSO Index}
\format{
A data frame with 827 rows and 2 variables:
\describe{
\item{time}{Time (seconds since 1970-01-01T00:00:00Z) [-6.31152E8, 1.5410304E9]}
\item{MEI}{MEI Index () [-2.247, 3.008]}
}
}
\source{
\url{https://oceanview.pfeg.noaa.gov/erddap/info/cciea_OC_MEI/index.html}
}
\usage{
cciea_OC_MEI
}
\description{
This calculation is an attempt to monitor ENSO by basing the Multivariate ENSO Index (MEI) on the six main observed variables over the tropical Pacific. These six variables are: sea-level pressure, zonal and meridional components of the surface wind, sea surface temperature, surface air temperature, and total cloudiness fraction of the sky. These observations have been collected and published in ICOADS for many years. The MEI is computed separately for each of twelve sliding bi-monthly seasons (Dec/Jan, Jan/Feb,..., Nov/Dec). After spatially filtering the individual fields into clusters (Wolter, 1987), the MEI is calculated as the first unrotated Principal Component (PC) of all six observed fields combined. This is accomplished by normalizing the total variance of each field first, and then performing the extraction of the first PC on the co-variance matrix of the combined fields (Wolter and Timlin, 1993). In order to keep the MEI comparable, all seasonal values are standardized with respect to each season and to the 1950-93 reference period.
}
\concept{dataset_erddap}
\keyword{datasets}
