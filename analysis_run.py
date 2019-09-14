import os
import copy
import pathlib
from exception_and_warnings import *
from jinja2 import Environment, FileSystemLoader

TEMPLATE_DIR = os.path.join(os.path.dirname(os.path.realpath(__file__)), "templates")


def prepare_files(work_dir, config):
    with open(os.path.join(work_dir, "analysis.R"), "w") as analysis_file, \
            open(os.path.join(work_dir, "task.bash"), "w") as task_file:
        j2_env = Environment(loader=FileSystemLoader(TEMPLATE_DIR),
                             trim_blocks=True)

        rendered_code = j2_env.get_template('analysis.R').render(**config)
        analysis_file.write(rendered_code)
        rendered_task = j2_env.get_template('task.bash').render(**config)
        task_file.write(rendered_task)


def analysis_run(config):
    work_dir = config["AnalysisFolder"]
    pathlib.Path(work_dir).mkdir(parents=True, exist_ok=True)
    prepare_files(work_dir, config)


def analysis(config):
    pathlib.Path(config["PathToAnalysis"]).mkdir(parents=True, exist_ok=True)
    if config['Merge']:
        if len(config['SampleIds']) > 1:
            config_local = copy.deepcopy(config)
            config_local["AnalysisFolder"] = os.path.join(config["PathToAnalysis"], "merged")
            config_local["AnalysisType"] = "many"
            if not config_local["FilterUMI"] or config_local['WholeUMI']:
                analysis_run(config_local)
                config_local['WholeUMI'] = False
            if config_local["FilterUMI"]:
                config_local["AnalysisFolder"] = os.path.join(config_local["AnalysisFolder"], "filtered")
                analysis_run(config_local)
        else:
            warnings.warn("Less than two samples but `Merge` set True, skipping merge")

    if config['RunSingleAnalysis']:
        for i, sample in enumerate(config["SampleIds"]):
            config_local = copy.deepcopy(config)
            config_local["AnalysisFolder"] = os.path.join(config["PathToAnalysis"],
                                                          config["SampleIds"][i])
            if config["Objects"]:
                config_local["Object"] = config["Objects"][i]
            else:
                config_local["SampleId"] = config["SampleIds"][i]
                config_local["PathToCount"] = config["PathsToCounts"][i]
            config_local["AnalysisType"] = "single"
            if not config_local["FilterUMI"] or config_local['WholeUMI']:
                analysis_run(config_local)
                config_local['WholeUMI'] = False
            if config_local["FilterUMI"]:
                config_local["AnalysisFolder"] = os.path.join(config_local["AnalysisFolder"], "filtered")
                analysis_run(config_local)
