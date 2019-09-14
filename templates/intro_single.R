

{% if Objects %}
fdata <- get(load("{{ Object }}"))
fdata@Dimnames[[1]] <-
  make.names(gsub(".ENS.*", "", fdata@Dimnames[[1]]), unique = T)
whole <- CreateSeuratObject(
  counts = fdata,
  min.cells = 2,
  min.features = 200,
  project = "{{ RunName }}"
)
whole <- add_metadata(whole)
{% endif %}

{% if PathsToCounts %}
fdata <- Read10X(data.dir = "{{ PathToCounts }}/{{ SampleId }}")
whole <- CreateSeuratObject(
  counts = fdata,
  min.cells = 2,
  min.features = 200,
  project = "{{ RunName }}"
)
whole <- add_metadata(whole)
{% endif%}