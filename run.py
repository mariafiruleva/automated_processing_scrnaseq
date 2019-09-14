from pipeline import pipeline
import argparse

parser = argparse.ArgumentParser(description="""10x single cell pipelines for CHPC

This pipeline performs sample alignment and further R analysis using
torque queueing system and written for ITMO University cluster

This pipeline requires single file with yaml configuration
Required fields in this YAML file are:

RunName: name of your run in a string format
SampleIds: [list of name separated by comma]
Objects: paths where count matrixes locate (including filenames)
PathsToCounts: paths where cellranger outputs locate (excluding filename)
PathToAnalysis: path where to put further R analysis

Pay attention: you must specify Objects or PathsToCounts, not both arguments

""", formatter_class=argparse.RawDescriptionHelpFormatter)
parser.add_argument("config", help="YAML configuration for pipeline run", metavar="YAML_FILE")


def main():
    args = parser.parse_args()
    pipeline(args.config)


if __name__ == "__main__":
    main()
