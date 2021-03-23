import os
import time
import clingo

__author__ = "Hannes Weichelt"
__credits__ = ["Hannes Weichelt", "Tom Schmidt", "Julian Bruhns"]
__license__ = "GPL"
__version__ = "1.0.1"
__maintainer__ = "Hannes Weichelt"
__email__ = "hweichelt@uni-postdam.de"
__status__ = "Development"

# cannot be 'occurs'
original_occurs_format = 'occurs1'
merger_file_name = 'final_M_merger_fixed.lp'


class PyMerger:
    @staticmethod
    def get_merger_content():
        script_path = os.path.dirname(os.path.abspath(__file__))
        print(f"load merger from : {script_path}/{merger_file_name}")
        f = open(f"{script_path}/{merger_file_name}", "r")
        merger_content = f.read()
        f.close()
        return merger_content

    @staticmethod
    def get_max_horizon(full_files_string):
        curr_horizon = None
        for line in full_files_string.split('\n'):
            if '#const horizon' in line:
                horizon_str = line.split('=')[1].split('.')[0].strip()

                # check if the horizon statement format is correct
                try:
                    horizon = int(horizon_str)
                except ValueError:
                    raise ValueError(f"Invalid horizon format in line : '{line}'")

                # check if there are multiple conflicting horizon statements in files
                if curr_horizon:
                    if curr_horizon != horizon:
                        raise ValueError(f"Two different horizon statements were found in files with the values:"
                                         f"'{horizon}', '{curr_horizon}'")

                # set the current detected horizon to the found valid horizon
                curr_horizon = horizon

        if curr_horizon:
            return curr_horizon
        else:
            raise ValueError("No horizon constant found in input files. Please define the constant '#const horizon=n.' in "
                             "your benchmark instance file.")

    @staticmethod
    def contains_plans(full_files_string):
        for line in full_files_string.split('\n'):
            if line.startswith(original_occurs_format):
                return True
        return False

    @staticmethod
    def remove_horizon_lines(full_files_string):
        # remove all the lines from input string that contain '#const horizon'
        return '\n'.join([line for line in full_files_string.split('\n') if '#const horizon' not in line])

    @staticmethod
    def solve(full_files_string):
        ctl = clingo.Control()
        ctl.add("base", [], full_files_string)

        print("-- start solving")
        start_t = time.perf_counter()
        ctl.ground([("base", [])])
        solution = ctl.solve(yield_=True)
        print(f"-- end solving")

        res = ""
        print("-- yield model")
        with solution as handle:
            for m in handle:
                res = "{}".format(m)
            handle.get()

        end_t = time.perf_counter()

        # returns (result), (solving time), (if instance is solvable)
        return res, end_t - start_t, bool(res)

    @staticmethod
    def iterative_solver(full_files_string, max_horizon):
        input_str_no_horizon = PyMerger.remove_horizon_lines(full_files_string)
        lowest_possible_horizon = None
        for h in range(1, max_horizon + 1):
            print(f"+ trying to solve with horizon : {h}")
            result, solving_time, solvable = PyMerger.solve(input_str_no_horizon + f"\n#const horizon={h}.")
            if solvable:
                lowest_possible_horizon = h
                break

        return lowest_possible_horizon, result, solving_time

    @staticmethod
    def merge(input_string):
        # read in all the '.lp' files that are given as parameter
        input_files = input_string
        # check if there are '.lp' input files given to solve
        if input_files:
            pass
        else:
            raise ValueError("No (no valid) input files found! Please give at least one valid '.lp' file as parameter")

        # read in the Merger file
        input_files += '\n' + PyMerger.get_merger_content()

        maximal_horizon = PyMerger.get_max_horizon(input_files)

        if not PyMerger.contains_plans(input_files):
            raise ValueError(f"No (no valid) plan files found! Please give at least one valid '.lp' file as parameter that "
                             f"contains the robots plans in the form of '{original_occurs_format}'!\nIf this is not the "
                             f"original plans format of your choice just change the 'original_occurs_format' constant in "
                             f"'main.py'")

        print(f"+ start solving with max horizon : {maximal_horizon}")
        start_iteration_time = time.time()
        lowest_horizon, best_result, time_single = PyMerger.iterative_solver(input_files, maximal_horizon)
        end_iteration_time = time.time()

        print("+" + "-"*30)
        if lowest_horizon:
            print(f"Solution found in a horizon of [{lowest_horizon}]!")
            print("SOLVABLE")
            print(f"Solving time (full search) : {end_iteration_time - start_iteration_time}")
            print(f"Solving time (single solvable instance) : {time_single}")
            print(f"Answer :")
            print('. '.join(best_result.split()) + '.')
            return best_result, end_iteration_time - start_iteration_time, True
        else:
            print("Solution couldn't be fount (in given horizon range)")
            print("UNSOLVABLE")
            print(f"Solving time (full search) : {end_iteration_time - start_iteration_time}")
            return None, end_iteration_time - start_iteration_time, False




