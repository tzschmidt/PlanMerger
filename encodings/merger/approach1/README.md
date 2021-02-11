# Approach 1

Merger encodings do not include benchmarks and should be run with a fitting benchmark and horizon. Expects input plans in the form of occurs1(...). Identical Versions with different instances are noted with \_N. Parameter #const horizon=10. needs to be set in the benchmarks or be taken into account in the command.
benchmark.lp files in this directory are only for testing and will be removed later. For finished benchmarks check /instances/benchmarks/

- **Version 1**
    + Generates possible movement delays at different moments in time, if collisions were detected
    + Can not detect new collisions caused by waiting
    + !not complete/ does not run!
- **Version 2**
    + Same idea as Version 1
    + removes plans with new collisions
    + does not iterate until all collisions resolved, but chooces other plan (could cause problems on plans with little possible wait variations
    + can solve vertex constraints (benchmarks 1 and 5)
    + TODO edge constraints
- **Version 3**
    + adds edge constraints to V2
    + merged plans seem unintuitive due to randomness
    + benchmark tests successful
    + horizon moved to benchmarks
- **Version 4**
    + additional features
    + locking: lock(object(robot,R)) in the benchmark causes this robot not ot deviate from its orignial plan
    + TODO A-domain: merger can merge M- and A-domain plans
- **Version 5**
    + A-domain: merger can merge M- and A-domain plans



# Merger Performance



## Merger Version 2

| Instance Name                                        | Solving Time (in s)   | In Horizon | Vertex Conflicts | Edge Conflicts | Invalid Movements | Shelves Reached |
| ---------------------------------------------------- | --------------------- | ---------- | ---------------- | -------------- | ----------------- | --------------- |
| 01_vertex_constraint_benchmark [Level 1]             | 0.003209352493286133  | True       | 0                | 0              | 0                 | 2/2             |
| 02_edge_constraint_benchmark [Level 1]               | 0.004174232482910156  | True       | 0                | 1              | 0                 | 2/2             |
| 03_multi_robot_vertex_constraint_benchmark [Level 3] | 0.006537199020385742  | True       | 2                | 2              | 0                 | 4/4             |
| 04_multi_robot_edge_constraint_benchmark [Level 3]   | 0.006299495697021484  | True       | 0                | 2              | 0                 | 4/4             |
| 05_multi_robot_conflict_through_waiting [Level 2]    | 0.0049495697021484375 | True       | 0                | 0              | 0                 | 3/3             |
| 06_long_vertex_conflict [Level 2]                    | 0.002974271774291992  | True       | 0                | 1              | 0                 | 2/2             |
| 07_marius_niklas_easy_center_conflict                | 0.0011162757873535156 | True       | 0                | 0              | 0                 | 2/2             |
| 08_marius_niklas_easy_conflict_square                | 0.0030269622802734375 | True       | 0                | 1              | 0                 | 2/2             |
| 09_marius_niklas_easy_corridor                       | 0.0030646324157714844 | True       | 0                | 1              | 0                 | 2/2             |
| 10_marius_niklas_easy_other_side                     | 0.0027685165405273438 | True       | 1                | 2              | 0                 | 3/3             |
| 13_marcus_max_3-robots_bench_test_10                 | 0.003240823745727539  | True       | 2                | 0              | 0                 | 3/3             |
| 14_marcus_max_3-robots_bench_test_11                 | 0.003022432327270508  | True       | 1                | 2              | 0                 | 3/3             |
| 15_marcus_max_3-robots_bench_test_12                 | 0.005147218704223633  | True       | 2                | 0              | 0                 | 3/3             |
| 16_marcus_max_3-robots_bench_test_13                 | 0.005137443542480469  | True       | 3                | 1              | 0                 | 3/3             |
| 17_marcus_max_3-robots_bench_test_14                 | 0.004224061965942383  | True       | 1                | 1              | 0                 | 3/3             |
| 18_marcus_max_4-robots_bench_test_15                 | 0.006793022155761719  | True       | 0                | 0              | 0                 | 4/4             |
| 19_marcus_max_4-robots_bench_test_15_mod             | 0.004689455032348633  | True       | 3                | 1              | 0                 | 4/4             |
| 20_multiple_dodges_necessary [Level 3]               | 0.0019826889038085938 | True       | 0                | 1              | 0                 | 2/2             |



## Merger Version 3

| Instance Name                                        | Solving Time (in s)           | In Horizon | Vertex Conflicts | Edge Conflicts | Invalid Movements | Shelves Reached |
| ---------------------------------------------------- | ----------------------------- | ---------- | ---------------- | -------------- | ----------------- | --------------- |
| 01_vertex_constraint_benchmark [Level 1]             | 0.02515554428100586           | True       | 0                | 0              | 0                 | 2/2             |
| 02_edge_constraint_benchmark [Level 1]               | 0.028130769729614258          | True       | 0                | 0              | 0                 | 2/2             |
| 03_multi_robot_vertex_constraint_benchmark [Level 3] | 0.05709028244018555           | True       | 0                | 0              | 0                 | 4/4             |
| 04_multi_robot_edge_constraint_benchmark [Level 3]   | 0.05017876625061035           | True       | 0                | 0              | 0                 | 4/4             |
| 05_multi_robot_conflict_through_waiting [Level 2]    | 0.04083418846130371           | True       | 0                | 0              | 0                 | 3/3             |
| 06_long_vertex_conflict [Level 2]                    | 0.027996301651000977          | True       | 0                | 0              | 0                 | 1/2             |
| 07_marius_niklas_easy_center_conflict                | 0.007253885269165039          | True       | 0                | 0              | 0                 | 2/2             |
| 08_marius_niklas_easy_conflict_square                | 0.024639606475830078          | True       | 0                | 0              | 0                 | 2/2             |
| 09_marius_niklas_easy_corridor                       | 0.025656938552856445          | True       | 0                | 0              | 0                 | 2/2             |
| 10_marius_niklas_easy_other_side                     | 0.03583121299743652           | True       | 0                | 0              | 0                 | 3/3             |
| 13_marcus_max_3-robots_bench_test_10                 | 0.033922433853149414          | True       | 0                | 0              | 0                 | 3/3             |
| 14_marcus_max_3-robots_bench_test_11                 | 0.04411172866821289           | True       | 0                | 0              | 0                 | 3/3             |
| 15_marcus_max_3-robots_bench_test_12                 | 0.040903329849243164          | True       | 0                | 0              | 0                 | 3/3             |
| 16_marcus_max_3-robots_bench_test_13                 | 0.03704023361206055           | True       | 0                | 0              | 0                 | 3/3             |
| 17_marcus_max_3-robots_bench_test_14                 | 0.03979921340942383           | True       | 0                | 0              | 0                 | 3/3             |
| 18_marcus_max_4-robots_bench_test_15                 | 0.05465984344482422           | True       | 0                | 0              | 0                 | 4/4             |
| 19_marcus_max_4-robots_bench_test_15_mod             | NOT SOLVABLE OR ERROR OCCURED | False      | 1                | 1              | 1                 | 0/0             |
| 20_multiple_dodges_necessary [Level 3]               | NOT SOLVABLE OR ERROR OCCURED | False      | 1                | 1              | 1                 | 0/0             |



## Merger Version 4 and 5

| Instance Name                                        | Solving Time (in s)           | In Horizon | Vertex Conflicts | Edge Conflicts | Invalid Movements | Shelves Reached |
| ---------------------------------------------------- | ----------------------------- | ---------- | ---------------- | -------------- | ----------------- | --------------- |
| 01_vertex_constraint_benchmark [Level 1]             | 0.02347421646118164           | True       | 0                | 0              | 0                 | 2/2             |
| 02_edge_constraint_benchmark [Level 1]               | 0.024822235107421875          | True       | 0                | 0              | 0                 | 2/2             |
| 03_multi_robot_vertex_constraint_benchmark [Level 3] | 0.0558466911315918            | True       | 0                | 0              | 0                 | 4/4             |
| 04_multi_robot_edge_constraint_benchmark [Level 3]   | 0.04657602310180664           | True       | 0                | 0              | 0                 | 4/4             |
| 05_multi_robot_conflict_through_waiting [Level 2]    | 0.03601360321044922           | True       | 0                | 0              | 0                 | 3/3             |
| 06_long_vertex_conflict [Level 2]                    | 0.027541399002075195          | True       | 0                | 0              | 0                 | 2/2             |
| 07_marius_niklas_easy_center_conflict                | 0.007559776306152344          | True       | 0                | 0              | 0                 | 2/2             |
| 08_marius_niklas_easy_conflict_square                | 0.023807764053344727          | True       | 0                | 0              | 0                 | 2/2             |
| 09_marius_niklas_easy_corridor                       | 0.02602839469909668           | True       | 0                | 0              | 0                 | 2/2             |
| 10_marius_niklas_easy_other_side                     | 0.03547549247741699           | True       | 0                | 0              | 0                 | 3/3             |
| 13_marcus_max_3-robots_bench_test_10                 | 0.032131195068359375          | True       | 0                | 0              | 0                 | 3/3             |
| 14_marcus_max_3-robots_bench_test_11                 | 0.041132211685180664          | True       | 0                | 0              | 0                 | 3/3             |
| 15_marcus_max_3-robots_bench_test_12                 | 0.03632545471191406           | True       | 0                | 0              | 0                 | 3/3             |
| 16_marcus_max_3-robots_bench_test_13                 | 0.03607320785522461           | True       | 0                | 0              | 0                 | 3/3             |
| 17_marcus_max_3-robots_bench_test_14                 | 0.03679656982421875           | True       | 0                | 0              | 0                 | 3/3             |
| 18_marcus_max_4-robots_bench_test_15                 | 0.045566558837890625          | True       | 0                | 0              | 0                 | 4/4             |
| 19_marcus_max_4-robots_bench_test_15_mod             | 0.04951333999633789           | True       | 0                | 0              | 0                 | 4/4             |
| 20_multiple_dodges_necessary [Level 3]               | NOT SOLVABLE OR ERROR OCCURED | False      | 1                | 1              | 1                 | 0/0             |