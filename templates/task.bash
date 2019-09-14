#!/bin/bash

sbatch << ENDINPUT
#!/bin/bash

{% if AnalysisType == "single" %}
#SBATCH --job-name={{ RunName }}_{{SampleId}}
{% elif AnalysisType == "many" %}
#SBATCH --job-name={{ RunName }}_merged
{% endif %}

#SBATCH --cpus-per-task={{ Threads }}
#SBATCH --mem={{ TaskMem }}G
#SBATCH --time={{ TaskWalltime }}:00:00
#SBATCH --output={{ AnalysisFolder }}/analysis.log

cd {{ AnalysisFolder }}
/scratch/opt/R/3.6.0/bin/Rscript analysis.R


ENDINPUT
