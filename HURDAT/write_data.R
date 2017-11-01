#' @title write_data
#'
#' @author Tim Trice
#'
#' @description Write HURDAT data to CSV, SQL
#'
#' @details Write the discus, fstadv, posest, prblty, public, update and wndprb
#' datasets to CSV and SQL.
#'
#' @param NA
#'
#' @examples NA

## ---- Libraries ----
library(dplyr)
library(glue)
library(HURDAT)
library(readr)

## ---- Settings ----
#' Intentionally Left Blank '#

## ---- Options ----
#' Intentionally Left Blank '#

## ---- Variables ----
#' Intentionally Left Blank '#

## ---- Functions ----
#' Intentionally Left Blank '#

## ---- Data ----
df <- bind_rows(AL %>% mutate(Basin = "AL"),
                EP %>% mutate(Basin = "EP"))

## ---- * Cleaning ----
#' Intentionally Left Blank '#

## ---- Execution ----

# Build data directories
csv_dir <- "./HURDAT/csv"
sql_dir <- "./HURDAT/sql"

if (!dir.exists(csv_dir)) dir.create(csv_dir)
if (!dir.exists(sql_dir)) dir.create(sql_dir)

# Write CSV
write_csv(df, path = sprintf("%s/HURDAT.csv", csv_dir))

# Write SQL
fcon <- file(sprintf("%s/HURDAT.sql", sql_dir), open = "wt")

# * Set max_allowed_packet
writeLines("-- Set max_allowed_packet.", fcon)
writeLines("SET GLOBAL max_allowed_packet=50*1024*1024;\n", fcon)

# * Drop database if exists
writeLines("-- Drop database HURDAT if it already exists.", fcon)
writeLines("DROP DATABASE IF EXISTS `HURDAT`;\n", fcon)

# * Create database
writeLines("-- Create HURDAT Database", fcon)
writeLines("CREATE DATABASE `HURDAT`;\n", fcon)

writeLines("USE `HURDAT`;\n", fcon)

# * Create table HURDAT
writeLines("-- Create HURDAT table", fcon)
writeLines(glue('CREATE TABLE `HURDAT` (
                \t`storm_key` CHAR(8) NOT NULL,
                \t`name` VARCHAR(10) NOT NULL,
                \t`basin` ENUM("AL", "EP") NOT NULL,
                \t`date_time` DATETIME NOT NULL,
                \t`record` ENUM("", "C", "G", "I", "L", "P", "R", "S", "T", "W") DEFAULT NULL,
                \t`status` ENUM("", "DB", "ET", "EX", "HU", "LO", "PT", "SD", "SS", "ST", "TD", "TS", "WV") DEFAULT NULL,
                \t`lat` FLOAT(3, 1) UNSIGNED DEFAULT NULL,
                \t`lon` FLOAT(4, 1) DEFAULT NULL,
                \t`wind` SMALLINT(3) UNSIGNED DEFAULT NULL,
                \t`pressure` SMALLINT(4) UNSIGNED DEFAULT NULL,
                \t`ne34` SMALLINT(4) UNSIGNED DEFAULT NULL,
                \t`se34` SMALLINT(4) UNSIGNED DEFAULT NULL,
                \t`sw34` SMALLINT(4) UNSIGNED DEFAULT NULL,
                \t`nw34` SMALLINT(4) UNSIGNED DEFAULT NULL,
                \t`ne50` SMALLINT(4) UNSIGNED DEFAULT NULL,
                \t`se50` SMALLINT(4) UNSIGNED DEFAULT NULL,
                \t`sw50` SMALLINT(4) UNSIGNED DEFAULT NULL,
                \t`nw50` SMALLINT(4) UNSIGNED DEFAULT NULL,
                \t`ne64` SMALLINT(4) UNSIGNED DEFAULT NULL,
                \t`se64` SMALLINT(4) UNSIGNED DEFAULT NULL,
                \t`sw64` SMALLINT(4) UNSIGNED DEFAULT NULL,
                \t`nw64` SMALLINT(4) UNSIGNED DEFAULT NULL);\n\n'),
           fcon)

df$Record[is.na(df$Record)] <- ""
df$Status[is.na(df$Status)] <- ""
df$Wind[is.na(df$Wind)] <- 0
df$Pressure[is.na(df$Pressure)] <- 0
df$NE34[is.na(df$NE34)] <- 0
df$SE34[is.na(df$SE34)] <- "NULL"
df$SW34[is.na(df$SW34)] <- "NULL"
df$NW34[is.na(df$NW34)] <- "NULL"
df$NE50[is.na(df$NE50)] <- "NULL"
df$SE50[is.na(df$SE50)] <- "NULL"
df$SW50[is.na(df$SW50)] <- "NULL"
df$NW50[is.na(df$NW50)] <- "NULL"
df$NE64[is.na(df$NE64)] <- "NULL"
df$SE64[is.na(df$SE64)] <- "NULL"
df$SW64[is.na(df$SW64)] <- "NULL"
df$NW64[is.na(df$NW64)] <- "NULL"

# * Insert data
writeLines("-- Insert storm data.", fcon)
writeLines("INSERT INTO `HURDAT` VALUES ", fcon)
insert_statements <- glue("\t(\"{df$Key}\", \"{df$Name}\", \"{df$Basin}\", \"{df$DateTime}\", \"{df$Record}\", \"{df$Status}\", {df$Lat}, {df$Lon}, {df$Wind}, {df$Pressure}, {df$NE34}, {df$SE34}, {df$SW34}, {df$NW34}, {df$NE50}, {df$SE50}, {df$SW50}, {df$NW50}, {df$NE64}, {df$SE64}, {df$SW64}, {df$NW64})")
writeLines(collapse(glue("{insert_statements}"), sep = ", \n"), fcon)
writeLines(";\n", fcon)

# * Data validation
writeLines("-- Data Validation", fcon)
writeLines(glue("SELECT 'There are {nrow(df)} records in original dataframe.' AS `Count`;\n"), fcon)
writeLines("SELECT COUNT(*) FROM HURDAT;\n", fcon)

# * Reset max_allowed_packet
writeLines("-- Reset max_allowed_packet.", fcon)
writeLines("SET GLOBAL max_allowed_packet=4*1024*1024;", fcon)

close(fcon)

## ---- Reset Options ----
#' Intentionally Left Blank '#
