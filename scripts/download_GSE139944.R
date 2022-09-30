options(timeout = 60000)

library(GEOquery)
args <- commandArgs(trailingOnly = TRUE)
work_dir <- args[1]

download_dir <- paste0(work_dir, 'download')
dir.create(download_dir)
getGEOSuppFiles("GSE139944", makeDirectory=FALSE, baseDir=download_dir)
