from apsrilo_preparation import prep
from tkinter import filedialog as fd, messagebox
import sys
import os


# instance_dir = "/home/hannes/Programming/PlanMerger/instances/benchmarks"

def get_instance_dir():
    script_path = os.path.dirname(os.path.realpath(__file__))
    filename = script_path + '/instance_dir.txt'
    if os.path.isfile(filename):
        f = open(filename, "r")
        directory = f.read()
        f.close()
        if os.path.isdir(directory):
            return directory
        else:
            messagebox.showwarning(title="Warning", message="Warning : Couldn't find the instance directory! Please"
                                                            "select a valid one.")
            res = fd.askdirectory(title="DIRECTORY NOT FOUND : Select Instance Directory")
    else:
        messagebox.showinfo(title="Welcome!", message="Before using the benchmark loader you have to select "
                                                      "your instance directory ")
        res = fd.askdirectory(title="FIRST USE : Select Instance Directory")
    if res:
        f = open(filename, "w")
        f.write(res)
        f.close()
        return res
    else:
        return get_instance_dir()


if __name__ == '__main__':
    instance_dir = get_instance_dir()

    to_file = False
    output_dir = None
    if sys.argv:
        prev = ""
        for x in sys.argv:
            if x == "-f":
                to_file = True
            elif x == "-d":
                prev = x
            elif prev == "-d":
                output_dir = x

    prep(instance_dir=instance_dir, advanced_benchmark_structure=True, to_file=to_file, output_directory=output_dir)

# -f to export output to file
# -d [directory] to specify output directory
