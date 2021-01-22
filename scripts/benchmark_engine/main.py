#!/usr/bin/env python

from BenchmarkEngine.benchmark import Benchmark, BenchmarkBinder

if __name__ == '__main__':

    # Initialising a new Benchmark with it's folders path
    b1 = Benchmark("/home/hannes/Programming/PlanMerger/instances/benchmarks/1_vertex_constraint_benchmark [Level 1]")
    b2 = Benchmark("/home/hannes/Programming/PlanMerger/instances/benchmarks/2_edge_constraint_benchmark [Level 1]")
    b3 = Benchmark("/home/hannes/Programming/PlanMerger/instances/benchmarks/3_multi_robot_vertex_constraint_benchmark [Level 3]")
    b4 = Benchmark("/home/hannes/Programming/PlanMerger/instances/benchmarks/4_multi_robot_edge_constraint_benchmark [Level 3]")
    b5 = Benchmark("/home/hannes/Programming/PlanMerger/instances/benchmarks/5_multi_robot_conflict_through_waiting [Level 2]")
    b6 = Benchmark("/home/hannes/Programming/PlanMerger/instances/benchmarks/6_long_vertex_conflict [Level 2]")

    # creating a new empty binder
    binder = BenchmarkBinder()

    # adding a benchmark to the binder
    binder.add_benchmark(b1)
    binder.add_benchmark(b2)
    binder.add_benchmark(b3)
    binder.add_benchmark(b4)
    binder.add_benchmark(b5)
    binder.add_benchmark(b6)

    # preprocessing for the file that contains the calculated occurs. (won't be necessary in the future)
    # moves_b6 = Benchmark.read_movements_from_file('res.lp')
    moves_b1 = Benchmark.read_movements_from_file('res_b1.lp')
    moves_b2 = Benchmark.read_movements_from_file('res_b2.lp')
    moves_b3 = Benchmark.read_movements_from_file('res_b3.lp')
    moves_b4 = Benchmark.read_movements_from_file('res_b4.lp')
    moves_b5 = Benchmark.read_movements_from_file('res_b5.lp')
    moves_b6 = Benchmark.read_movements_from_file('res_b6.lp')

    # evaluation of all the benchmarks stored in the binder (the parameter is the path of the merger.lp file)
    binder.evaluate("/home/hannes/Programming/PlanMerger/encodings/merger/approach1/mergerV3.lp", verbose=1)
    # binder.evaluate("/home/hannes/Programming/Asprilo/testspace/app_4/mergerTest.lp", verbose=1)

    # Be careful not to evaluate 2 Binders at the same time because the plot images are always deleted before a new
    # evaluation takes place
