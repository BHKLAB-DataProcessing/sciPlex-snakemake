options(timeout = 60000)

library(GEOquery)
args <- commandArgs(trailingOnly = TRUE)
work_dir <- args[1]

getGEOSuppFiles("GSE139944", makeDirectory=FALSE, baseDir=work_dir)
