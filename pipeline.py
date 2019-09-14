import yaml
from analysis_run import analysis

def pipeline(config_file_name):
    with open(config_file_name) as config, \
            open("defaults.yaml") as defaults:
        run_dict = yaml.load(defaults, Loader=yaml.FullLoader)
        config_dict = yaml.load(config, Loader=yaml.FullLoader)
        run_dict.update(config_dict)
    assert run_dict['RunName'], "You must specify RunName"
    assert run_dict['SampleIds'], "Number of SampleIds can not be zero"
    assert len(run_dict['SampleIds']) == len(run_dict['Objects']), "SampleIds number must correspond to Objects number"
    assert (run_dict['Objects'] and not run_dict['PathsToCounts']) or (not run_dict['Objects'] and run_dict['PathsToCounts']), "Specify Objects or PathsToCounts"
    assert run_dict['PathToAnalysis'], "PathToAnalysis can not be empty"
    analysis(run_dict)

