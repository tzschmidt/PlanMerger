#!/usr/bin/env python

import clingo
import matplotlib.pyplot as plt
import numpy as np
import os
import webbrowser
import time
import multiprocessing
import copy
from Merger.merger import PyMerger
from abc import ABC

__author__ = "Hannes Weichelt"
__credits__ = ["Hannes Weichelt", "Tom Schmidt", "Julian Bruhns"]
__license__ = "GPL"
__version__ = "1.0.3"
__maintainer__ = "Hannes Weichelt"
__email__ = "hweichelt@uni-postdam.de"
__status__ = "Development"

colors = ['red', 'blue', 'yellow', 'green', 'purple', 'pink', 'orange', 'grey', 'lime', 'black']

class Benchmark:

    def __init__(self, *inp, verbose=0):

        if len(inp) == 1:
            path = inp[0]
            self.path = path
            self.name = path.split('/')[-1]
            inits, robot_movements, instance = self.read_benchmark_files(path)

            # initialise the dictionaries (self.robots and self.shelves) and the lists (self.nodes, self.highways)
            self.robots, self.shelves, self.nodes, self.highways = self.format_benchmark_inits(inits)
            # initialise the dictionary self.original_plans which contains the original plans movements
            self.original_plans = self.format_benchmark_movements(robot_movements)

            # Fill the original plans with [0,0] movements at the timesteps where there is not movement
            self.original_plans = self.get_filled_plans(self.original_plans)
            
            h = self.get_benchmark_horizon(instance)
            if h == -1:
                raise RuntimeError("Benchmark Format Error : The Benchmark hast to contain a time horizon in the form"
                                   "(#const horizon=[0>h])")
            self.horizon = h

            if verbose:
                print(f"nodes: {self.nodes}")
                print(f"highways: {self.highways}")
                print(f"shelves: {self.shelves}")
                print(f"robots: {self.robots}")
                print(f"original plans: {self.original_plans}")
                self.plot()

        else:
            raise ValueError("Benchmarks can only be initialised with either (benchmark_path) or "
                             "(inits, robot_movements) as parameters")

    @staticmethod
    def read_benchmark_files(path):
        instance, plans = Benchmark.import_benchmark(path)
        inits, robot_movements = Benchmark.format_benchmark_files(instance, plans)
        return inits, robot_movements, instance

    @staticmethod
    def format_benchmark_files(instance, plans):
        inits = Benchmark.split_statements(instance)['init']
        robot_movements = []
        for i, plan in enumerate(plans):
            if 'occurs1' in Benchmark.split_statements(plan):
                robot_movements += Benchmark.split_statements(plan)['occurs1']
            else:
                print(plan)
                raise ValueError("NO 'occurs1' statements found in plan!")
        return inits, robot_movements

    @staticmethod
    def import_benchmark(path):
        if os.path.isdir(path):
            if os.path.isdir(path + "/full_instance") and os.path.isdir(path + "/plans"):
                first_lp_instance = list(filter(lambda x: x.endswith('.lp'), os.listdir(path + '/full_instance')))[0]
                f = open(f"{path}/full_instance/{first_lp_instance}", "r")
                instance_str = f.read()
                f.close()

                # format the instance string so that all inits have not empty spaces
                line_list = []
                for line in instance_str.split('\n'):
                    if line.startswith('init('):
                        line_list.append(line.replace(' ', ''))
                    else:
                        line_list.append(line)
                instance = '\n'.join(line_list)

                plans = []
                for plan in os.listdir(path + "/plans"):
                    if plan.split('.')[-1] == 'lp':
                        f = open(f"{path}/plans/{plan}", "r")
                        # TODO : replacing all spaces and then replacing all newlines with spaces
                        plans.append(f.read().replace(' ', '').replace('\n', ' '))
                        f.close()

                return instance, plans
            else:
                raise ValueError(
                    "The given directory structure for the selected benchmark is incompatible with this programm")
                # Not the correct Benchmark structure
        else:
            raise ValueError("Cannot find the directory given")
            # Not the right path selected

    @staticmethod
    def split_statements(strng):
        res = {}
        strng_split = strng.split()
        for s in strng_split:
            if s.endswith('.'):
                open_b_count = s.count('(')
                closed_b_count = s.count(')')
                if open_b_count and open_b_count == closed_b_count:
                    s_content = ')'.join(('('.join(s.split('(')[1:])).split(')')[:-1])
                    if s.split('(')[0] in res:
                        res[s.split('(')[0]].append(s_content)
                    else:
                        res[s.split('(')[0]] = [s_content]
        return res

    @staticmethod
    def get_benchmark_horizon(strng):
        horizon = -1
        strng_split = strng.split()
        for s in strng_split:
            if s.endswith('.'):
                if 'horizon' in s:
                    horizon = int(s.split('=')[-1][:-1])
        return horizon

    @staticmethod
    def format_benchmark_inits(inits):
        # [robots, shelves, nodes, highways]
        res = [{}, {}, [], []]

        for init in inits:
            name = Benchmark.get_object_name(init)
            if name[0] == 'robot':
                res[0][int(name[1])] = Benchmark.get_object_value(init)
            elif name[0] == 'shelf':
                res[1][int(name[1])] = Benchmark.get_object_value(init)
            elif name[0] == 'node':
                res[2].append(Benchmark.get_object_value(init))
            elif name[0] == 'highway':
                res[3].append(Benchmark.get_object_value(init))

        return res[0], res[1], res[2], res[3]

    @staticmethod
    def format_benchmark_movements(robot_movements):
        res = {}
        for movement in robot_movements:
            time_step = int(movement.split(',')[-1])
            action = ','.join(movement.split(',')[:-1])

            name = Benchmark.get_object_name(action)
            if int(name[1]) in res:
                res[int(name[1])].append([time_step, Benchmark.get_object_value(action)])
            else:
                res[int(name[1])] = [[time_step, Benchmark.get_object_value(action)]]
        return res

    @staticmethod
    def get_object_name(strng):
        return strng.split('(')[1].split(')')[0].split(',')

    @staticmethod
    def get_object_value(strng):
        val_str = (')'.join(strng.split(')')[1:]))[1:]
        val_content_str = ('('.join(val_str.split('(')[1:]))[:-1]
        values_str = ','.join(val_content_str.split(',')[1:])
        return [int(val) for val in values_str[1:-1].split(',')]

    @staticmethod
    def get_filled_plans(plans):
        filled_plans = plans
        max_t = max(max([[move[0] for move in plan] for plan in list(filled_plans.values())], key=lambda x: max(x)))
        for robot_id in list(filled_plans.keys()):
            plan = filled_plans[robot_id]

            # add a [0,0] movement for each timestep where the robot doesn't change its position.
            for t in range(1, max_t+1):
                if t not in [pos[0] for pos in plan]:
                    plan.append([t, [0, 0]])
            # sort the resulting plan to have a realistic timeline
            plan_sorted = sorted(plan, key=lambda x: x[0])
            filled_plans[robot_id] = plan_sorted
        return filled_plans

    def calculate_plan_positions(self, plan, robot_id):
        plan_sorted = sorted(plan, key=lambda x: x[0])
        start_pos = self.robots[robot_id]

        times = [0]
        positions = [start_pos]
        pos = np.array(start_pos)
        for move in plan_sorted:
            pos += np.array(move[1])
            times.append(move[0])
            positions.append(list(pos))
        return times, np.array(positions)

    def check_solution(self, plans):
        position_data = []
        max_t = - np.inf
        for plan in sorted(list(zip(plans.keys(), plans.values())), key=lambda x: x[0]):
            time, pos = self.calculate_plan_positions(plan[1], plan[0])
            position_data.append(pos)
            if max(time) > max_t:
                max_t = max(time)
        position_data = np.array(position_data)

        vertex_conflicts = self.get_vertex_conflicts(position_data)
        edge_conflicts = self.get_edge_conflicts(position_data)
        invalid_movements = self.get_invalid_movements(position_data)
        final_pos_reached = self.check_if_final_position_is_reached(position_data)

        conflicts = {'vertex_conflicts': vertex_conflicts, 'edge_conflicts': edge_conflicts}
        return not vertex_conflicts and not edge_conflicts, conflicts, invalid_movements, max_t, final_pos_reached

    def check_if_final_position_is_reached(self, position_data):
        last_pos = [plan[-1] for plan in position_data]
        goal_pos = []
        for plan in sorted(list(zip(self.original_plans.keys(), self.original_plans.values())), key=lambda x: x[0]):
            _, pos = self.calculate_plan_positions(plan[1], plan[0])
            goal_pos.append(np.array(pos[-1]))
        shelve_reached = []
        for comp in list(zip(last_pos, goal_pos)):
            shelve_reached.append((comp[0] == comp[1]).all())

        return shelve_reached

    def get_invalid_movements(self, position_data):
        invalid_movements = []
        for robot_id, plan_pos in enumerate(position_data):
            for t, pos in enumerate(plan_pos):
                if list(pos) not in self.nodes:
                    invalid_movements.append([t, pos])
        return invalid_movements

    @staticmethod
    def get_vertex_conflicts(position_data):
        vertex_conflicts = []
        # for each robot's plan go through every step and compare with the other robots positions
        for robot_id, plan_pos in enumerate(position_data):
            for t, pos in enumerate(plan_pos):
                for other_plan in np.concatenate((position_data[:robot_id], position_data[robot_id + 1:])):
                    # check if the robot and any of the other robots are at the same place at the same time
                    if (pos == other_plan[t]).all():
                        conflicts_tmp = [[c[0], list(c[1])] for c in vertex_conflicts]
                        if [t, list(pos)] not in conflicts_tmp:
                            vertex_conflicts.append([t, pos])
        return vertex_conflicts

    @staticmethod
    def get_edge_conflicts(position_data):
        edge_conflicts = []
        # for each robot's plan go through every step and compare with the other robots positions
        for robot_id, plan_pos in enumerate(position_data):
            for t, pos in enumerate(plan_pos):
                for other_plan in np.concatenate((position_data[:robot_id], position_data[robot_id + 1:])):
                    # check if the robot and any of the other robots are switching positions
                    if t + 1 < len(other_plan):
                        if (pos == other_plan[t + 1]).all():
                            if t + 1 < len(plan_pos):
                                if (plan_pos[t + 1] == other_plan[t]).all():
                                    # check if the edge conflict is not already detected, but from the other robot
                                    conflicts_tmp = [[c[0], list(c[1]), list(c[2])] for c in edge_conflicts]
                                    if [t, list(other_plan[t]), list(pos)] not in conflicts_tmp:
                                        edge_conflicts.append([t, pos, other_plan[t]])
        return edge_conflicts

    @staticmethod
    def read_movements_from_file(path):
        if os.path.isfile(path):
            if path.endswith('.lp'):
                f = open(path, "r")
                plan = f.read()
                f.close()

                res = Benchmark.read_movements_from_string(plan)

                return res

    @staticmethod
    def read_movements_from_string(plan):
        robot_movements = Benchmark.split_statements(plan)['occurs']
        moves = Benchmark.format_benchmark_movements(robot_movements)
        res = Benchmark.get_filled_plans(moves)

        return res

    def print_original_plans(self):
        print(f'% Original Plans - {self.name}:')
        for plan in self.original_plans.items():
            print(f'% [ Original Plan Robot {plan[0]} ]')
            for move in plan[1]:
                print(f'occurs1(object(robot,{plan[0]}),action(move,({move[1][0]},{move[1][1]})),{move[0]}).')

    def plot(self, plans=None, original_plans=True, scale_factor=1, show_text=True, edge_conflicts=None,
             vertex_conflicts=None, final_pos_reached=None, save_path=None):
        np_nodes = np.array(self.nodes)
        max_x = np_nodes[:, 0].max()
        max_y = np_nodes[:, 1].max()

        fig, ax = plt.subplots(figsize=(max_x * 3 * scale_factor, max_y * 2 * scale_factor))
        ax.set_xlim(0, max_x)
        ax.set_ylim(0, max_y)
        ax.grid()
        ax.set_xticks(list(range(max_x + 1)))
        ax.set_yticks(list(range(max_y + 1)))
        # plt.gca().set_xticklabels([])
        # plt.gca().set_yticklabels([])

        for node in self.nodes:
            if node not in self.highways:
                rectangle = plt.Rectangle((node[0] - 1, node[1] - 1), 1, 1, fc='blue', alpha=0.125)
                ax.add_patch(rectangle)

        for highway in self.highways:
            rectangle = plt.Rectangle((highway[0] - 1, highway[1] - 1), 1, 1, fc='green', alpha=0.125)
            ax.add_patch(rectangle)

        for robot in list(zip(self.robots.keys(), self.robots.values())):
            ax.scatter(robot[1][0] - 0.5, robot[1][1] - 0.5, s=(10 ** 3.5) * scale_factor,
                       c=colors[(robot[0] - 1) % len(colors)], marker='s', alpha=0.5)
            if scale_factor >= 0.5 and show_text:
                ax.annotate(f'robot {robot[0]}', (robot[1][0] - 0.63, robot[1][1] - 0.53))

        for shelf in list(zip(self.shelves.keys(), self.shelves.values())):
            ax.scatter(shelf[1][0] - 0.5, shelf[1][1] - 0.5, s=(10 ** 3.5) * scale_factor,
                       c=colors[(shelf[0] - 1) % len(colors)], marker='o', alpha=0.5)
            if scale_factor >= 0.5 and show_text:
                ax.annotate(f'shelf {shelf[0]}', (shelf[1][0] - 0.62, shelf[1][1] - 0.53))

        if original_plans:
            for plan in list(zip(self.original_plans.keys(), self.original_plans.values())):
                times, positions = self.calculate_plan_positions(plan[1], plan[0])
                ax.plot(positions.T[0] - 0.5, positions.T[1] - 0.5, c=colors[(plan[0] - 1) % len(colors)], alpha=0.125,
                        linewidth=5 * scale_factor,
                        marker='o')

        if plans:
            for plan in list(zip(plans.keys(), plans.values())):
                times, positions = self.calculate_plan_positions(plan[1], plan[0])
                ax.plot(positions.T[0] - 0.5, positions.T[1] - 0.5, c=colors[(plan[0] - 1) % len(colors)], alpha=0.25,
                        linewidth=15 * scale_factor,
                        marker='o', markersize=15 * scale_factor)

        if edge_conflicts:
            print('plotting edges')
            for conflict in edge_conflicts:
                pos = [(conflict[1][0] + conflict[2][0]) / 2, (conflict[1][1] + conflict[2][1]) / 2]
                ax.scatter(pos[0] - 0.5, pos[1] - 0.5, s=(10 ** 3) * scale_factor, c='red', marker='$[EC]$', alpha=0.75)

        if vertex_conflicts:
            for conflict in vertex_conflicts:
                ax.scatter(conflict[1][0] - 0.5, conflict[1][1] - 0.5, s=(10 ** 3) * scale_factor, c='red',
                           marker='$[VC]$', alpha=0.75)

        if final_pos_reached:
            for i, reached in enumerate(final_pos_reached):
                shelf = self.shelves[i+1]
                shelf = plt.Rectangle((shelf[0] - 1, shelf[1] - 1), 1, 1, ec=['#F44336', '#7CB342'][reached],
                                       fc='none', linewidth=10 * scale_factor, alpha=0.75)
                ax.add_patch(shelf)

        if save_path:
            print(f'saving plot at {save_path}')
            plt.savefig(save_path)
        else:
            plt.show()


class RandomBenchmark(Benchmark):
    def __init__(self, size_x, size_y, n_robots, time_horizon=10, verbose=0, random_seed=None):
        path = f'RANDOM BENCHMARK {size_x}X-{size_y}Y-{n_robots}R'
        self.path = path
        self.name = path.split('/')[-1]
        # inits, robot_movements, instance = self.read_benchmark_files(path)

        self.n_robots = n_robots

        rand_size_map, rand_robots, rand_shelves = self.gen_benchmark_data(size_x, size_y, n_robots, random_seed=random_seed)
        rand_plans = self.gen_simple_robot_plans(rand_robots, rand_shelves)
        str_nodes, str_plans, str_robots, str_shelves = self.format_output(rand_size_map, rand_plans)

        self.instance = '\n' + str_robots + '\n' + str_shelves + '\n' + str_nodes + '\n' + f'#const horizon={time_horizon}.'
        self.plans_str_split = self.split_plans_str(str_plans)
        inits, robot_movements = self.format_benchmark_files(self.instance, self.plans_str_split)

        # initialise the dictionaries (self.robots and self.shelves) and the lists (self.nodes, self.highways)
        self.robots, self.shelves, self.nodes, self.highways = self.format_benchmark_inits(inits)
        # initialise the dictionary self.original_plans which contains the original plans movements
        self.original_plans = self.format_benchmark_movements(robot_movements)

        # Fill the original plans with [0,0] movements at the timesteps where there is not movement
        self.original_plans = self.get_filled_plans(self.original_plans)

        h = self.get_benchmark_horizon(self.instance)
        if h == -1:
            raise RuntimeError("Benchmark Format Error : The Benchmark hast to contain a time horizon in the form"
                               "(#const horizon=[0>h].)")
        self.horizon = h

        if verbose:
            print(f"nodes: {self.nodes}")
            print(f"highways: {self.highways}")
            print(f"shelves: {self.shelves}")
            print(f"robots: {self.robots}")
            print(f"original plans: {self.original_plans}")
            self.plot()

    @staticmethod
    def split_plans_str(plans):
        occurs = plans.split('\n')
        plans = {}
        for o in occurs:
            robot_id = int(o.split('robot,')[1].split(')')[0])
            if robot_id in plans:
                plans[robot_id] += '\n' + o
            else:
                plans[robot_id] = o
        return list(plans.values())

    @staticmethod
    def get_random_pos(max_x, max_y):
        if max_x > 0 and max_y > 0:
            return [np.random.randint(1, max_x + 1), np.random.randint(1, max_y + 1)]
        else:
            raise ValueError("max_x and max_y have to be greater than 0!")

    @staticmethod
    def gen_benchmark_data(size_x, size_y, n_robots, random_seed=None):
        if size_x * size_y > n_robots * 2:
            robot_pos = []
            shelf_pos = []
            if random_seed:
                np.random.seed(random_seed)

            for n in range(n_robots):
                not_unique_pos = True
                while not_unique_pos:
                    r_pos = RandomBenchmark.get_random_pos(size_x, size_y)
                    s_pos = RandomBenchmark.get_random_pos(size_x, size_y)
                    if (r_pos not in robot_pos + shelf_pos) and (s_pos not in shelf_pos + robot_pos) and r_pos != s_pos:
                        not_unique_pos = False
                robot_pos.append(r_pos)
                shelf_pos.append(s_pos)
            return (size_x, size_y), robot_pos, shelf_pos
        else:
            raise ValueError(f"Your chosen Map size is too small to contain {n_robots} robots and shelves")

    @staticmethod
    def gen_simple_robot_plans(robot_pos, shelf_pos):
        res = []
        for pos in list(zip(robot_pos, shelf_pos)):
            plan = []
            d_x = pos[1][0] - pos[0][0]
            d_y = pos[1][1] - pos[0][1]
            if d_x != 0:
                movements_x = list(range(np.sign(d_x), d_x + np.sign(d_x), np.sign(d_x)))
            else:
                movements_x = []
            if d_y != 0:
                movements_y = list(range(np.sign(d_y), d_y + np.sign(d_y), np.sign(d_y)))
            else:
                movements_y = []

            shuffle = lambda x, y: [[x, y], [y, x]][np.random.randint(0, 1)]
            shuffled_dirs = shuffle([[x, 0] for x in movements_x], [[0, y] for y in movements_y])
            for m_1 in shuffled_dirs[0]:
                plan.append(np.sign(np.array(m_1)))
            for m_2 in shuffled_dirs[1]:
                plan.append(np.sign(np.array(m_2)))

            res.append([pos[0], pos[1], plan])

        return res

    @staticmethod
    def format_output(size_map, plans):
        nodes_str = []
        plans_str = []
        robots_str = []
        shelves_str = []
        i = 1
        for x in range(size_map[0]):
            for y in range(size_map[1]):
                nodes_str.append(f'init(object(node,{i}),value(at,({x + 1},{y + 1}))).')
                i += 1

        for i, plan in enumerate(plans):
            robots_str.append(f'init(object(robot,{i + 1}),value(at,({plan[0][0]},{plan[0][1]}))).')
            shelves_str.append(f'init(object(shelf,{i + 1}),value(at,({plan[1][0]},{plan[1][1]}))).')
            for t, pos in enumerate(plan[2]):
                plans_str.append(f'occurs1(object(robot,{i + 1}),action(move,({pos[0]},{pos[1]})),{t + 1}).')

        return '\n'.join(nodes_str), '\n'.join(plans_str), '\n'.join(robots_str), '\n'.join(shelves_str)


class BenchmarkBinder:

    def __init__(self):
        self.benchmarks = []

        manager = multiprocessing.Manager()
        self.shared_solvable = manager.Value('b', False)
        self.shared_solving_time = manager.Value('d', 0.0)
        self.shared_plan = manager.Value('s', "")

    def add_benchmark(self, benchmark):
        self.benchmarks.append(benchmark)

    def add_benchmark_from_path(self, path):
        self.benchmarks.append(Benchmark(path))

    def add_all_benchmarks_in_dir(self, path):
        if os.path.isdir(path):
            for file in sorted(os.listdir(path)):
                if os.path.isdir(f"{path}/{file}") and not file.startswith('%'):
                    if os.path.exists(f"{path}/{file}/full_instance") and os.path.exists(f"{path}/{file}/plans"):
                        print(f"Benchmark added : {file}")
                        self.add_benchmark_from_path(f"{path}/{file}")

    def remove_benchmark(self, index):
        if 0 <= index < len(self.benchmarks):
            del self.benchmarks[index]

    def get_benchmarks(self):
        return self.benchmarks

    def __str__(self):
        res = '[\n'
        for b in self.benchmarks:
            res += b.name + '\n'
        return res + ']'

    def solve_with_merger(self, benchmark, merger_path, use_python_merger):
        if merger_path:
            print('start solving')
            plan, solving_time, solvable = ClingoSolver.solve(merger_path, benchmark)
            print('finished solving')
        elif use_python_merger:
            full_benchmark_str = ClingoSolver.get_full_benchmark_string(benchmark)
            plan, solving_time, solvable = PyMerger.merge(full_benchmark_str)  # using the complete time
        else:
            raise ValueError("this function has to either get a '.lp' merger path or has to be run with the internal"
                             "python merger")

        self.shared_solvable.value = solvable
        self.shared_solving_time.value = solving_time
        self.shared_plan.value = plan

    def evaluate(self, merger_path=None, verbose=1, use_python_merger=False, max_solving_time=60, output_text_file=False,
                 output_file_name=None):
        if output_text_file or output_file_name:
            if verbose != 1:
                raise ValueError("Text output only works in verbose=1 mode!")
            if not (output_text_file and output_file_name):
                raise ValueError("To output to a textfile please also choose an output_file_name")
            if '\\' in output_file_name or '/' in output_file_name or '.' in output_file_name:
                raise ValueError("Invalid output_file_name format (no / or \\ or .)")
        if max_solving_time < 0:
            raise ValueError("max_solving_time is the upper threshold for solving the benchmarks. Its value has to be"
                             "greater than zero")
        if merger_path and use_python_merger:
            raise ValueError("It is only possible to use either a normal .lp merger or a python merger.")
        verbose_plotting_depth = 2
        if (use_python_merger or (os.path.isfile(merger_path) and merger_path.endswith('.lp'))) and self.benchmarks:
            # Remove all of the old plot images in the output/imgs folder
            image_list = [f for f in os.listdir('output/imgs') if f.endswith(".png")]
            for f in image_list:
                os.remove(os.path.join('output/imgs/', f))

            conflict_list = []
            name_list = []
            path_list = []
            image_paths = []
            invalid_movement_list = []
            in_horizon_list = []
            solving_times = []
            final_pos_reached_list = []
            solvable_list = []

            for i, benchmark in enumerate(self.benchmarks):
                print(benchmark.name)

                # All the Benchmarks in the binder are solved with clingo and the 'occurs' output is returned
                # If the Benchmark is solvable the checkers outputs are appended to the output lists, if not some
                # standard values are appended instead

                # MULTIPROCESSING PART : Still under construction (may contain some errors)
                # TODO : finish multiprocessing part + check for errors
                process = multiprocessing.Process(target=self.solve_with_merger, args=(benchmark, merger_path, use_python_merger))
                process.start()
                process.join(max_solving_time)
                timeout = False

                # If thread is active
                if process.is_alive():
                    print("!!! - Time Limit exceeded for merging : ABORT")
                    timeout = True
                    # Terminate
                    process.terminate()
                    process.join()

                if timeout:
                    plan = []
                    solving_time = 'TIMEOUT'
                    solvable = False
                else:
                    solvable = self.shared_solvable.value
                    solving_time = self.shared_solving_time.value
                    plan = self.shared_plan.value

                # END OF MULTIPROCESSING PART

                solvable_list.append(solvable)
                solving_times.append(solving_time)
                name_list.append(benchmark.name)
                path_list.append(benchmark.path)

                image_path = f"output/imgs/b_{i}.png"

                if solvable:
                    plan_formatted = '.\n'.join(plan.split()) + "."
                    plan_movements = Benchmark.read_movements_from_string(plan_formatted)

                    _, conflicts, invalid_movements, max_t, final_pos_reached = benchmark.check_solution(plan_movements)

                    conflict_list.append(conflicts)
                    invalid_movement_list.append(invalid_movements)
                    in_horizon_list.append(max_t <= benchmark.horizon)
                    final_pos_reached_list.append(final_pos_reached)

                    if verbose:
                        if isinstance(benchmark, RandomBenchmark):
                            print("- INSTANCE [\n" + benchmark.instance + "\n]")
                        print("- FINAL PLANS [\n" + plan_formatted + "\n]")

                    if verbose >= verbose_plotting_depth:
                        benchmark.plot(vertex_conflicts=conflicts['vertex_conflicts'],
                                       edge_conflicts=conflicts['edge_conflicts'],
                                       save_path=image_path, plans=plan_movements,
                                       final_pos_reached=final_pos_reached)

                else:
                    conflict_list.append({ "vertex_conflicts": [], "edge_conflicts": [] })
                    invalid_movement_list.append([])
                    in_horizon_list.append(False)
                    final_pos_reached_list.append([])

                    if verbose >= verbose_plotting_depth:
                        benchmark.plot(save_path=image_path)

                image_paths.append(image_path)

            # Deciding for the way of output :
            # verbose = 1 : only textual output
            # verbose = 2 : an html result sheet as output

            if verbose == 2:
                print(solvable_list)
                self.output_html(conflict_list, name_list, path_list, image_paths, invalid_movement_list, in_horizon_list,
                                 solving_times, final_pos_reached_list, solvable_list)

                html_file_path = '/'.join(os.path.realpath(__file__).split('/')[:-2]) + '/output/out.html'
                self.open_html_file(html_file_path)
            elif verbose == 1:
                text_out = self.output_text(conflict_list, name_list, path_list, invalid_movement_list, in_horizon_list,
                                            solving_times, final_pos_reached_list, solvable_list)
                print(text_out)

                f = open(f"output/{output_file_name}.txt", "a")
                f.write(text_out)
                f.close()

        else:
            raise ValueError("The Benchmark Binder is either empty or the Merger file path doesn't exist")

    @staticmethod
    def open_html_file(path):
        url = f"file://{path}"
        # new=2 to open in a new tab, if possible
        webbrowser.open(url, new=2)

    @staticmethod
    def output_text(results, names, paths, invalid_movements, in_horizon, solving_times, final_pos_reached_list,
                    solvable_list):
        res_str = ""
        if len(results) == len(names) == len(paths) == len(invalid_movements) == len(in_horizon) == len(solving_times)\
                == len(solvable_list):
            lens = [max([len(str(n)) for n in names] + [13]),
                    16,
                    8,
                    max([len(str(t)) for t in solving_times] + [19]),
                    max([len(str(h)) for h in in_horizon] + [10]),
                    max([len(str(len(r['vertex_conflicts']))) for r in results] + [16]),
                    max([len(str(len(r['edge_conflicts']))) for r in results] + [14]),
                    max([len(str(len(ivm))) for ivm in invalid_movements] + [17]),
                    max([len(str(len(sr)))*2+1 for sr in final_pos_reached_list] + [15])]
            head = "| {:" + str(lens[0]) + "s} | {:"\
                   + str(lens[1]) + "s} | {:"\
                   + str(lens[2]) + "s} | {:"\
                   + str(lens[3]) + "s} | {:"\
                   + str(lens[4]) + "s} | {:"\
                   + str(lens[5]) + "s} | {:"\
                   + str(lens[6]) + "s} | {:"\
                   + str(lens[7]) + "s} | {:"\
                   + str(lens[8]) + "s} |"
            res_str += head.format('Instance Name', 'Correct Solution', 'Solvable', 'Solving Time (in s)', 'In Horizon', 'Vertex Conflicts',
                                   'Edge Conflicts', 'Invalid Movements', 'Shelves Reached') + '\n'
            res_str += head.format('-'*lens[0], '-'*lens[1], '-'*lens[2], '-'*lens[3], '-'*lens[4], '-'*lens[5],
                                   '-'*lens[6], '-'*lens[7], '-'*lens[8]) + '\n'
            s = "| {:" + str(lens[0]) + "s} | {:"\
                + str(lens[1]) + "s} | {:" \
                + str(lens[2]) + "s} | {:" \
                + str(lens[3]) + "s} | {:"\
                + str(lens[4]) + "s} | {:"\
                + str(lens[5]) + "d} | {:"\
                + str(lens[6]) + "d} | {:" \
                + str(lens[7]) + "d} | {:" \
                + str(lens[8]) + "s} |"
            for i in range(len(results)):
                vcs = results[i]['vertex_conflicts']
                ecs = results[i]['edge_conflicts']
                ivm = invalid_movements[i]
                # print(f"| {names[i]} | {solving_times[i]} | {in_horizon[i]} | {len(vcs)} | {len(ecs)} | {len(ivm)} |")
                # TODO : schoener machen!
                correct = solvable_list[i] and in_horizon[i] and len(vcs) == 0 and len(ecs) == 0 and len(ivm) == 0 and sum(final_pos_reached_list[i]) == len(final_pos_reached_list[i])
                res_str += s.format(names[i], str(correct), str(solvable_list[i]), str(solving_times[i]), str(in_horizon[i]),
                                    len(vcs), len(ecs), len(ivm),
                                    f"{sum(final_pos_reached_list[i])}/{len(final_pos_reached_list[i])}") + '\n'

        return res_str

    @staticmethod
    def output_html(results, names, paths, image_paths, invalid_movements, in_horizon, solving_times,
                    final_pos_reached_list, solvable_list):
        if len(results) == len(names) == len(paths) == len(image_paths) == len(invalid_movements) == len(in_horizon)\
                == len(solving_times) == len(final_pos_reached_list) == len(solvable_list):
            f = open("html/quick.html", "r")
            quick = f.read()
            f.close()

            out = []
            quick_list = []
            for result_index in range(len(results)):
                f = open("html/vertex_conflict.html", "r")
                vc_template = f.read()
                f.close()

                f = open("html/edge_conflict.html", "r")
                ec_template = f.read()
                f.close()

                sol = solvable_list[result_index]

                vcs = []
                for vc in results[result_index]['vertex_conflicts']:
                    tmp = vc_template.replace('{{ X }}', f'{vc[1][0]}')
                    tmp = tmp.replace('{{ Y }}', f'{vc[1][1]}')
                    tmp = tmp.replace('{{ T }}', f'{vc[0]}')
                    vcs.append(tmp)

                ecs = []
                for ec in results[result_index]['edge_conflicts']:
                    tmp = ec_template.replace('{{ X1 }}', f'{ec[1][0]}')
                    tmp = tmp.replace('{{ Y1 }}', f'{ec[1][1]}')
                    tmp = tmp.replace('{{ X2 }}', f'{ec[2][0]}')
                    tmp = tmp.replace('{{ Y2 }}', f'{ec[2][1]}')
                    tmp = tmp.replace('{{ T }}', f'{ec[0]}')
                    ecs.append(tmp)

                ims = []
                for im in invalid_movements[result_index]:
                    tmp = vc_template.replace('{{ X }}', f'{im[1][0]}')
                    tmp = tmp.replace('{{ Y }}', f'{im[1][1]}')
                    tmp = tmp.replace('{{ T }}', f'{im[0]}')
                    ims.append(tmp)

                quick_with_id = quick.replace('{{ B INDEX }}', f'{result_index + 1}')

                f = open("html/benchmark.html", "r")
                b_template = f.read()
                f.close()

                passed_out = ['not-passed', 'passed']

                benchmark_out = b_template.replace('{{ VERTEX CONFLICTS }}', '\n'.join(vcs))
                benchmark_out = benchmark_out.replace('{{ EDGE CONFLICTS }}', '\n'.join(ecs))
                benchmark_out = benchmark_out.replace('{{ INVALID MOVEMENTS }}', '\n'.join(ims))
                benchmark_out = benchmark_out.replace('{{ NAME }}', names[result_index])
                benchmark_out = benchmark_out.replace('{{ PATH }}', paths[result_index])
                benchmark_out = benchmark_out.replace('{{ SOLVABLE }}', passed_out[sol])
                benchmark_out = benchmark_out.replace('{{ TIME }}', f"{solving_times[result_index]}s")
                benchmark_out = benchmark_out.replace('{{ IN HORIZON }}', passed_out[in_horizon[result_index]])
                benchmark_out = benchmark_out.replace('{{ VC PASSED }}', passed_out[not bool(vcs) and sol])
                benchmark_out = benchmark_out.replace('{{ EC PASSED }}', passed_out[not bool(ecs) and sol])
                benchmark_out = benchmark_out.replace('{{ IM PASSED }}', passed_out[not bool(ims) and sol])
                n_robots = len(final_pos_reached_list[result_index])
                n_reached = sum(final_pos_reached_list[result_index])
                reached_percentage = round((n_reached / n_robots) * 100) if n_robots else 0
                benchmark_out = benchmark_out.replace('{{ N ROBOTS }}', str(n_robots))
                benchmark_out = benchmark_out.replace('{{ N FINAL POSITIONS REACHED }}', str(n_reached))
                benchmark_out = benchmark_out.replace('{{ REACHED PERCENTAGE }}', str(reached_percentage))
                benchmark_out = benchmark_out.replace('{{ ALL REACHED }}', passed_out[n_robots == n_reached and sol])

                if not vcs and not ecs and not ims and in_horizon[result_index] and n_robots == n_reached and sol:
                    benchmark_out = benchmark_out.replace('{{ PASSED }}', 'passed')
                    quick_list.append(quick_with_id.replace('{{ PASSED }}', 'passed'))
                else:
                    benchmark_out = benchmark_out.replace('{{ PASSED }}', 'not-passed')
                    quick_list.append(quick_with_id.replace('{{ PASSED }}', 'not-passed'))

                benchmark_out = benchmark_out.replace('{{ IMAGE }}', '/'.join(image_paths[result_index].split('/')[1:]))
                res = benchmark_out.replace('{{ B INDEX }}', f'{result_index + 1}')

                out.append(res)

            f = open("html/index.html", "r")
            res_template = f.read()
            f.close()

            f = open("html/main.css", "r")
            style = f.read()
            f.close()

            out_string = res_template.replace('{{ BENCHMARKS }}', '\n'.join(out))
            out_string = out_string.replace('{{ STYLE }}', style)
            out_string = out_string.replace('{{ QUICK }}', '\n'.join(quick_list))

            f = open("output/out.html", "w")
            f.write(out_string)
            f.close()


class InvalidClingoOutputException(Exception):
    """Raised when the Clingo Solver cannot find either a valid or any model"""
    pass


class ClingoSolver(ABC):

    @staticmethod
    def solve_with_clingo(full_asp_string, horizon_replacement=None):
        if horizon_replacement:
            full_asp_string = ClingoSolver.remove_horizon_lines(full_asp_string)
            full_asp_string += f'\n#const horizon={horizon_replacement}.'

        ctl = clingo.Control()
        ctl.add("base", [], full_asp_string)

        res = ""

        start = time.time()
        ctl.ground([("base", [])])
        solution = ctl.solve(yield_=True)
        end = time.time()

        with solution as handle:
            # TODO : not pretty, might have to be changed in the future
            for m in handle:
                res = "{}".format(m)
            handle.get()

        return res, end - start, bool(res)

    @staticmethod
    def get_full_benchmark_string(benchmark):
        # TODO : Duplicated, delete in solve and replace
        try:
            instance, plans = Benchmark.import_benchmark(benchmark.path)
        except ValueError:
            # TODO: check if benchmark is random benchmark (if and oly if):
            if isinstance(benchmark, RandomBenchmark):
                instance = benchmark.instance
                plans = benchmark.plans_str_split

        plans_formatted = '\n'.join(['\n'.join(plan.split()) for plan in plans])

        full_benchmark_str = instance + "\n" + plans_formatted + "\n" + f"#const horizon={benchmark.horizon}."

        return full_benchmark_str

    @staticmethod
    def solve(merger_path, benchmark, horizon_replacement=None):
        f = open(merger_path, "r")
        merger = f.read()
        f.close()

        try:
            instance, plans = Benchmark.import_benchmark(benchmark.path)
        except ValueError:
            # TODO: check if benchmark is random benchmark (if and oly if):
            if isinstance(benchmark, RandomBenchmark):
                instance = benchmark.instance
                plans = benchmark.plans_str_split

        full_benchmark_str = instance + "\n" + "\n".join(plans) + "\n" + "\n" + merger

        return ClingoSolver.solve_with_clingo(full_benchmark_str, horizon_replacement=horizon_replacement)

    @staticmethod
    def remove_horizon_lines(string):
        res = []
        for line in string.split('\n'):
            if '#const horizon' not in line:
                res.append(line)
        return '\n'.join(res)

    @staticmethod
    def get_smallest_horizon(merger_path, benchmark, range_end, range_start=1, range_step=1):
        if range_end >= range_start >= 0:
            for horizon in range(range_start, range_end, range_step):
                res, solving_time, solvable = ClingoSolver.solve(merger_path, benchmark, horizon_replacement=horizon)
                if solvable:
                    return horizon, res, solving_time
        # return None when in the given range there is no solvable solution
        return None

