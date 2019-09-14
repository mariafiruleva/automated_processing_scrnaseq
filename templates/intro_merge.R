

options(future.globals.maxSize = 8000 * 1024^2)

whole <- c()
names <- c()

{% for Object in Objects %}
data <- get(load("{{ Object }}"))
data@Dimnames[[1]] <-
  make.names(gsub(".ENS.*", "", data@Dimnames[[1]]), unique = T)
data <-
  CreateSeuratObject(
    counts = data,
    min.cells = 2,
    project = "{{ RunName }}",
    min.features = 200
  )
data <- add_metadata(data)
data$sample <- "{{ SampleIds[loop.index0] }}"
assign(paste0('data_', "{{ SampleIds[loop.index0] }}"), data)
whole <- c(get(paste0('data_', "{{ SampleIds[loop.index0] }}")), whole)
names <- c(gsub('.sparse.RData', '', gsub('.*_', '', "{{ Object }}")), names) # extract SRS from /path/SRA*_SRS*.sparse.RData
{% endfor %}
whole <- as.list(whole)
names(whole) <- names
rm(list=ls(pattern='data'))