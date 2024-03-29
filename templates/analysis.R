library(dplyr)
library(functools)
library(ggplot2)
library(gridExtra)
library(Matrix)
library(sctransform)
library(Seurat)

## FUNCTIONS
{% include 'add_metadata.R' %}
{% include 'draw_plots.R' %}
{% if FilterMito %}
{% include 'get_conf_interval.R' %}
{% endif %}
{%  if FilterMito and AnalysisType == "many"%}
{% include 'filter_mito_func.R' %}
{% endif %}

{% if FilterUMI and not WholeUMI %}
{% include 'peakfinder.R' %}
{% endif %}
{%  if FilterUMI and not WholeUMI and AnalysisType == "many"%}
{% include 'filter_umi_func.R' %}
{% endif %}


## GATHERING DATA TOGETHER
{% if AnalysisType == "single" %}
    {% include 'intro_single.R' %}
{% elif AnalysisType == "many" %}
    {% include 'intro_merge.R' %}
{% endif %}


## CREATE DIRECTORY FOR PLOTS
{% include 'plot_dir_creation.R' %}


## Number of cells before
{% include 'cells_before.R' %}


## FILTER MT CONTENT
{% if FilterMito %}
{% include 'mt_filtering.R' %}
{% endif %}


{% if not FilterUMI or WholeUMI %}
## NORMALIZATION
{% include 'normalization.R' %}


## PCA
{% include 'pca.R' %}


## TSNE
{% include 'tsne.R' %}


## UMAP
{% include 'umap.R' %}


## CLUSTERING
{% include 'clustering.R' %}


## VISUALIZATION
{% include 'visualization.R' %}


## AVERAGING
{% include 'average.R' %}


## FINDING ANS SAVING MARKERS
{% include 'markers.R' %}


## SAVING
{% include 'save.R' %}


## Number of cells after
{% include 'cells_after.R' %}



{% else %}
## FILTER nUMI
{% include 'umi_filtering.R' %}


## NORMALIZATION: FILTERED DATASET
{% include 'normalization.R' %}


## PCA: FILTERED DATASET
{% include 'pca.R' %}


## TSNE: FILTERED DATASET
{% include 'tsne.R' %}


## UMAP: FILTERED DATASET
{% include 'umap.R' %}


## CLUSTERING: FILTERED DATASET
{% include 'clustering.R' %}


## VISUALIZATION: FILTERED DATASET
{% include 'visualization.R' %}


## AVERAGING: FILTERED DATASET
{% include 'average.R' %}


## FINDING MARKERS: FILTERED DATASET
{% include 'markers.R' %}


## SAVING: FILTERED DATASET
{% include 'save.R' %}



## Number of cells after
{% include 'cells_after.R' %}
{% endif %}

