whole <-
  RunTSNE(whole, dims = 1:{{ PcaComponentsTsne }}, tsne.method = "FIt-SNE",
          fast_tsne_path = "{{ PathToFastTsne }}", nthreads = {{ Threads }}, max_iter = 2000)