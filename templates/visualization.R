
{% if AnalysisType == "single" %}
draw_plots(path, whole)
{% elif AnalysisType == "many" %}
sapply(whole, draw_plots, path=path)
{% endif %}