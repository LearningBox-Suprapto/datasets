# HURDAT

This [dataset](http://www.nhc.noaa.gov/data/#hurdat) contains best-track data of most known tropical cyclones in the northwestern hemisphere (north Atlantic, northeast and north-central Pacific oceans). The dataset is maintained by the [Hurricane Research Division](http://www.aoml.noaa.gov/hrd/data_sub/re_anal.html) (HRD) of the National Oceanic and Atmospheric Administration (NOAA). It is generally updated once a year; typically spring.

This current dataset contains storm data up to year 2015. The earliest years of data are:

* Atlantic: 1851
* East Pacific: 1949
* Central Pacific: 1950

As with any dataset, validation should be performed prior to analysis. I know of at least two instances where longitude values are incorrect. 

The raw dataset (not included) is in CSV format. The [codebook](http://www.nhc.noaa.gov/data/hurdat/hurdat2-format-atlantic.pdf) for the dataset is available from the National Hurricane Center (NHC). 

## Structure

Each format (csv, sql, rda) contains three tables: <var>Summary</var>, <var>Details</var>, and <var>Wind Radius</var>. Every row of <var>Summary</var> has many rows in <var>Details</var>. Some rows of <var>Details</var> has one row of <var>Wind Radius</var>. 
`key` is the **PRIMARY ID** in all three tables. `date_time` is a secondary foreign key to tie <var>Details</var> and <var>Wind Radius</var> together. 

<center>![HURDAT dataset model](https://github.com/timtrice/datasets/blob/master/HURDAT/HURDAT-data-model.png)</center>

## Issues

If you find issues with my copy of the dataset, please [let me know](https://github.com/timtrice/datasets/issues). If you find issues with the quality of the dataset you may [file an issue in the GitHub repository](https://github.com/timtrice/datasets/issues) and I will forward the errors to the maintainers of the raw dataset.
