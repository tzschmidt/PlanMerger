#!/usr/bin/env python

from BenchmarkEngine.benchmark import Benchmark, BenchmarkBinder, RandomBenchmark

if __name__ == '__main__':

    # Initialising a new Benchmark with it's folders path
    b1 = Benchmark("/home/hannes/Programming/PlanMerger/instances/benchmarks/1_vertex_constraint_benchmark [Level 1]")
    b2 = Benchmark("/home/hannes/Programming/PlanMerger/instances/benchmarks/2_edge_constraint_benchmark [Level 1]")
    b3 = Benchmark("/home/hannes/Programming/PlanMerger/instances/benchmarks/3_multi_robot_vertex_constraint_benchmark [Level 3]")
    b4 = Benchmark("/home/hannes/Programming/PlanMerger/instances/benchmarks/4_multi_robot_edge_constraint_benchmark [Level 3]")
    b5 = Benchmark("/home/hannes/Programming/PlanMerger/instances/benchmarks/5_multi_robot_conflict_through_waiting [Level 2]")
    b6 = Benchmark("/home/hannes/Programming/PlanMerger/instances/benchmarks/6_long_vertex_conflict [Level 2]")

    b_rand_1 = RandomBenchmark(5, 5, 11, time_horizon=11, random_seed=666)
    # b_rand_2 = RandomBenchmark(50, 50, 10, time_horizon=50, random_seed=42)
    b_rand_2 = RandomBenchmark(5, 5, 11, time_horizon=2, random_seed=42)
    # b_rand_3 = RandomBenchmark(10, 10, 30, time_horizon=20, random_seed=1337)

    # creating a new empty binder
    binder = BenchmarkBinder()

    # adding a benchmark to the binder
    binder.add_benchmark(b1)
    binder.add_benchmark(b2)
    binder.add_benchmark(b3)
    binder.add_benchmark(b4)
    binder.add_benchmark(b5)
    binder.add_benchmark(b6)
    binder.add_benchmark(b_rand_1)
    binder.add_benchmark(b_rand_2)
    # binder.add_benchmark(b_rand_3)

    # evaluation of all the benchmarks stored in the binder (the parameter is the path of the merger.lp file)
    binder.evaluate("/home/hannes/Programming/PlanMerger/encodings/merger/approach1/mergerV3.lp", verbose=1)
    # binder.evaluate("/home/hannes/Programming/Asprilo/testspace/app_4/mergerTest.lp", verbose=1)

    # Be careful not to evaluate 2 Binders at the same time because the plot images are always deleted before a new
    # evaluation takes place
