import tkinter as tk
from tkinter import filedialog as fd
from os import listdir


def prep(instance_dir, visual=True, advanced_benchmark_structure=False, to_file=False, output_directory=None):
    if visual:
        if advanced_benchmark_structure:
            benchmark_dir = fd.askdirectory(initialdir=instance_dir, title="Select the Benchmark")
            if benchmark_dir:
                instance = "/full_instance/" + list(filter(lambda x: x.endswith(".lp"), listdir(benchmark_dir + "/full_instance")))[0]
                plans = list(map(lambda x: "/plans/" + x, listdir(benchmark_dir + "/plans")))

                res = []
                for filename in list(plans) + [instance]:
                    f = open(benchmark_dir + "/" + filename, "r")
                    res.append(f.read())
                    f.close()

                res_string = ""
                for s in res:
                    res_string += s

                if to_file:
                    if not output_directory:
                        output_dir = fd.askdirectory(initialdir=instance_dir, title="Select the Output Directory")
                    else:
                        output_dir = output_directory
                    if output_directory:
                        f = open(output_dir + "/out.lp", "w")
                        f.write(res_string)
                        f.close()

                        f = open(output_dir + "/instance.lp", "w")
                        f.write(res[-1])
                        f.close()
                    else:
                        print("ERROR : NO OUTPUT DIRECTORY")
                else:
                    print(*res)

        else:
            instance = fd.askopenfilename(initialdir=instance_dir, title="Select the Instance")
            plans = fd.askopenfilenames(initialdir=instance_dir, title="Select the Plans")

            print(instance)
            print(plans)

            res = []
            for filename in list(plans) + [instance]:
                f = open(filename, "r")
                res.append(f.read())
                f.close()

            print(*res)
