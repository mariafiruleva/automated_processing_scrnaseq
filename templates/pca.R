
{% if AnalysisType == "single" %}
whole <- RunPCA(object = whole, features = VariableFeatures(object = whole), npcs={{ PcaComponentsTotal }})
{% elif AnalysisType == "many" %}
whole <- RunPCA(whole, verbose = FALSE)
{% endif %}