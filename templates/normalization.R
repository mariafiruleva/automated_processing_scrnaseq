{% if AnalysisType == "single" %}
whole <-
  SCTransform(
    whole,
    ncells=min(100000, ncol(whole)),
    vars.to.regress = c("percent.mito"),
    verbose = T,
    conserve.memory = T
  )
{% elif AnalysisType == "many" %}
whole <- sapply(whole, function(x) SCTransform(
  x,
  ncells=min(100000, ncol(x)),
  vars.to.regress = c("percent.mito"),
  verbose = T,
  conserve.memory = T
))
whole.features <- SelectIntegrationFeatures(object.list = whole, nfeatures = 2000)
whole <- PrepSCTIntegration(object.list = whole, anchor.features = whole.features, 
                            verbose = FALSE)
whole.anchors <- FindIntegrationAnchors(object.list = whole, normalization.method = "SCT", 
                                        anchor.features = whole.features, verbose = FALSE)
whole.integrated <- IntegrateData(anchorset = whole.anchors, normalization.method = "SCT", 
                                  verbose = FALSE)
{% endif %}

gc()
