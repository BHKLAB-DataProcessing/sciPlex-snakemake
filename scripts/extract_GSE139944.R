args <- commandArgs(trailingOnly = TRUE)
work_dir <- args[1]

data_dir <- paste0(work_dir, 'data')
dir.create(data_dir)

untar(file.path(work_dir, "download", "GSE139944_RAW.tar"), exdir = data_dir)
file.remove(file.path(data_dir, list.files(data_dir, pattern = "*.txt.gz")))
file.remove(file.path(data_dir, list.files(data_dir, pattern = "*.matrix.gz")))
file.remove(file.path(data_dir, "GSM4150378_sciPlex3_cds_all_cells.RDS"))
system(paste("gunzip", paste0(data_dir, "/*.RDS.gz")))