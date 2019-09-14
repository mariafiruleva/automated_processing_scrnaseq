## Automated analysis of scRNA-seq data

This pipeline implements strategy to automated analysis of your scRNA-seq data using CellRanger output or directly count matrix.

Analysis builds on [Seurat v3.1](https://satijalab.org/seurat/) package using [SCTransform](https://www.biorxiv.org/content/10.1101/576827v2) normalization method and include a way to integrate different dataset with common biological features (e.g., datasets which have obtained using different sequencing technology or datasets from different donors) and batch effect removing using Seurat [integration](https://satijalab.org/seurat/v3.1/integration.html) mode.

This pipeline have developed as a result of summer internship on [Bioinformatics Institute](bioinf.me) and [ITMO University](https://en.itmo.ru/en/) under the direction of Konstantin Zaitsev.

## Before you start

Please, before you start, install all the requirements using pip `pip install -r requirements.txt`. Python3 is required.

After you did all that, please refer to _example.yaml_ as YAML-configuration example.

Pipeline is run using `python run.py example.yaml`

If you want to generate YAML documents for PanglaoDB, install `yaml` library, change output_dir in `panglao_yaml_generation.R` and run `Rscript panglao_yaml_generation.R`
