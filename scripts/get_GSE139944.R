library(monocle3)
args <- commandArgs(trailingOnly = TRUE)
work_dir <- args[1]
filename <- args[2]

data_dir <- paste0(work_dir, 'data')

first <- readRDS(file.path(data_dir, "GSM4150376_sciPlex1_cds.RDS"))
matrix <- assay(first)
first_experiment <- SummarizedExperiment(assays = matrix,rowRanges = first@rowRanges,colData = first@colData)

second <- readRDS(file.path(data_dir, "GSM4150377_sciPlex2_cds.RDS"))
matrix <- assay(second)
second_experiment <- SummarizedExperiment(assay = matrix,rowRanges = second@rowRanges,colData = second@colData)


third_experiment <- list()
cell_type = c("A549","MCF7","K562")
for (i in cell_type) {
  object <- readRDS(file.path(data_dir, paste0("GSM4150378_sciPlex3_",i,"_24hrs.RDS", sep = "")))
  matrix <- assay(object)
  experiment <- SummarizedExperiment(assays = matrix,rowRanges = object@rowRanges,colData = object@colData)
  if (length(third_experiment)==0) {
    third_experiment <- list(experiment)
  }
  else{
  third_experiment <- append(third_experiment,experiment)
  }
  print(i)
}
names(third_experiment) <- cell_type

fourth <- readRDS(file.path(data_dir, "GSM4150379_sciPlex4_hdaci_cds.RDS"))
matrix <- assay(fourth)
fourth_experiment <- SummarizedExperiment(assay = matrix,rowRanges = fourth@rowRanges,colData = fourth@colData)

experiment <- list(first_experiment,second_experiment,third_experiment,fourth_experiment)
names(experiment) <- c("GSM4150376","GSM4150377","GSM4150378","GSM4150379")

unlink(data_dir, recursive=TRUE)

saveRDS(experiment, file.path(work_dir, filename))