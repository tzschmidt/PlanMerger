#!/usr/bin/env python

from BenchmarkEngine.benchmark import Benchmark, BenchmarkBinder, RandomBenchmark, ClingoSolver
import os

if __name__ == '__main__':

    benchmark_path = '/home/hannes/Programming/PlanMerger/instances/benchmarks'
    # benchmark_path = '/home/hannes/Programming/Asprilo/0_All_Benchmarks'

    #b1 = Benchmark(f"{benchmark_path}/1_vertex_constraint_benchmark [Level 1]")
    #b2 = Benchmark(f"{benchmark_path}/2_edge_constraint_benchmark [Level 1]")
    #b3 = Benchmark(f"{benchmark_path}/3_multi_robot_vertex_constraint_benchmark [Level 3]")
    #b4 = Benchmark(f"{benchmark_path}/4_multi_robot_edge_constraint_benchmark [Level 3]")
    #b5 = Benchmark(f"{benchmark_path}/5_multi_robot_conflict_through_waiting [Level 2]")
    #b6 = Benchmark(f"{benchmark_path}/6_long_vertex_conflict [Level 2]")
    #b7 = Benchmark(f"{benchmark_path}/7_multiple_dodges_necessary [Level 3]")

    b_rand_1 = RandomBenchmark(5, 5, 11, time_horizon=11, random_seed=666)
    # b_rand_2 = RandomBenchmark(50, 50, 10, time_horizon=50, random_seed=42)
    b_rand_2 = RandomBenchmark(15, 15, 50, time_horizon=25, random_seed=42)
    b_rand_3 = RandomBenchmark(10, 10, 30, time_horizon=20, random_seed=1337)
    b_rand_big = RandomBenchmark(100, 10, 10, time_horizon=90, random_seed=1337)
    b_rand_far = RandomBenchmark(40, 40, 10, time_horizon=60, random_seed=42)
    b_rand_far_2 = RandomBenchmark(40, 40, 30, time_horizon=60, random_seed=42)

    # creating a new empty binder
    binder = BenchmarkBinder()

    # adding a benchmark to the binder
    #binder.add_benchmark(b1)
    #binder.add_benchmark(b2)
    #binder.add_benchmark(b3)
    #binder.add_benchmark(b4)
    #binder.add_benchmark(b5)
    #binder.add_benchmark(b6)
    #binder.add_benchmark(b7)
    #binder.add_benchmark(b_rand_1)
    
    binder.add_all_benchmarks_in_dir(benchmark_path)
    #binder.add_benchmark(b_rand_big)
    #print(b_rand_far_2.instance)
    #b_rand_far_2.print_original_plans()
    
    #for i in range(50):
    #    binder.add_benchmark(RandomBenchmark(3, 3, 4, time_horizon=10))
    # binder.add_benchmark(b_rand_2)
    # binder.add_benchmark(b_rand_3)

    # evaluation of all the benchmarks stored in the binder (the parameter is the path of the Merger.lp file)
    # binder.evaluate("/home/hannes/Programming/PlanMerger/encodings/Merger/approach1/mergerV4.lp", verbose=2)

    #res_tjh = binder.evaluate(use_python_merger=True, verbose=1, max_solving_time=1800, output_text_file=True, output_file_name="RES_TOM_JULIAN_HANNES")
    res_tjh = binder.evaluate(use_python_merger=True, verbose=2, max_solving_time=1800)
    #res_a = binder.evaluate(merger_path="/home/hannes/Programming/Asprilo/0_All_Mergers/Merger_Adrian/merging.lp", verbose=1, max_solving_time=1800, output_text_file=True, output_file_name="RES_ADRIAN", occurs_format='occurs')
    #res_mm = binder.evaluate(merger_path="/home/hannes/Programming/Asprilo/0_All_Mergers/Merger_Max_Marcus/merger.lp", verbose=1, max_solving_time=1800, output_text_file=True, output_file_name="RES_MARCUS_MAX")
    #res_mn = binder.evaluate(merger_path="/home/hannes/Programming/Asprilo/0_All_Mergers/Merger_Niklas_Marius/random-moves-dynamic-time-minimize/merger.lp", verbose=1, max_solving_time=1800, output_text_file=True, output_file_name="RES_MARIUS_NIKLAS")
    #res_t = binder.evaluate(merger_path="/home/hannes/Programming/Asprilo/0_All_Mergers/Merger_Tarek/merge.lp", verbose=1, max_solving_time=1800, output_text_file=True, output_file_name="RES_TAREK")

    print("FINISHED ALL BENCHMARKING")

    # binder.evaluate("/home/hannes/Programming/Asprilo/testspace/app_6/mergerV5.lp", verbose=1)

    # print(ClingoSolver.get_smallest_horizon("/home/hannes/Programming/Asprilo/testspace/app_6/mergerV5.lp", b_rand_1, 11))

    # b_rand_3.print_original_plans()
    # print(ClingoSolver.solve("/home/hannes/Programming/Asprilo/testspace/app_6/mergerV4.lp", b_rand_3))
    # binder.evaluate("/home/hannes/Programming/Asprilo/testspace/app_4/mergerV4_0.lp", verbose=1)
    # b_rand_2.print_original_plans()
    # Be careful not to evaluate 2 Binders at the same time because the plot images are always deleted before a new
    # evaluation takes place
