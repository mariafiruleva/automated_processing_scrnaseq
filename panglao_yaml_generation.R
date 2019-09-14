library(yaml)
path <- '/scratch/mfiruleva/data/var/www/html/SRA/SRA.final/'
output_dir <- '/scratch/mfiruleva/autumn/generation/'

read_data <- function(path){
  files <- paste0(path, list.files(path = path)[grepl("_.*RData", list.files(path = path))])
  c(files)
}
files <- read_data(path)
sra_projects <- unique(gsub('_SRS.*', '', gsub('.sparse', '', gsub('.*/', '', files))))

for (sra_id in 1:length(sra_projects)) {
  task <- list()
  srs_files <- files[grepl(sra_projects[sra_id], files)]
  task$RunName <- sra_projects[sra_id]
  task$Objects <- srs_files
  task$SampleIds <- gsub('.sparse.RData', '', gsub('.*_', '', srs_files))
  task$PathsToCounts <- FALSE
  task$PathToAnalysis <- paste0(output_dir, sra_projects[sra_id])
  write_yaml(task, paste0(paste0(output_dir, "yamls/"), paste0(sra_projects[sra_id], '.yaml')))
}
