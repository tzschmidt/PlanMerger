# Approach 2

Merger encodings do not include benchmarks and should be run with a fitting benchmark and horizon. Expects input plans in the form of `occurs1(...)`. Identical Versions with different instances are noted with \_N. Parameter `#const horizon=10`. needs to be set in the benchmarks or be taken into account in the command.
`benchmark.lp` files in this directory are only for testing and will be removed later. For finished benchmarks check `/instances/benchmarks/`

- **Version 1**
    + Generates possible movement delays at different moments in time, if collisions were detected
    + Can not detect new collisions caused by waiting
    + !not complete/ does not run!
- **Version 2**
    + Same idea as Version 1
    + removes plans with new collisions
    + does not iterate until all collisions resolved, but chooses other plan (could cause problems on plans with little possible wait variations
    + can solve vertex constraints (benchmarks 1 and 5)
    + TODO : edge constraints
- **Version 3**
    + adds edge constraints to V2
    + merged plans seem unintuitive due to randomness
    + benchmark tests successful
    + horizon moved to benchmarks
- **Version 4**
    + additional features
    + locking: lock(object(robot,R)) in the benchmark causes this robot not ot deviate from its orignial plan
    + TODO A-domain: merger can merge M- and A-domain plans

**A-Domain**
- **Version 1**
    + A-domain: merger can merge M- and A-domain plans
    + multiple robots are allowed to access the same shelf in their original plans
    + benchmarks must contain "adomain." 



# Merger Performance



## Merger Version 2

| Instance Name                                        | Correct Solution | Solvable | Solving Time (in s)   | In Horizon | Vertex Conflicts | Edge Conflicts | Invalid Movements | Shelves Reached |
| ---------------------------------------------------- | ---------------- | -------- | --------------------- | ---------- | ---------------- | -------------- | ----------------- | --------------- |
| 01_vertex_constraint_benchmark [Level 1]             | True             | True     | 0.0031890869140625    | True       | 0                | 0              | 0                 | 2/2             |
| 02_edge_constraint_benchmark [Level 1]               | False            | True     | 0.004202842712402344  | True       | 0                | 1              | 0                 | 2/2             |
| 03_multi_robot_vertex_constraint_benchmark [Level 3] | False            | True     | 0.006711721420288086  | True       | 2                | 2              | 0                 | 4/4             |
| 04_multi_robot_edge_constraint_benchmark [Level 3]   | False            | True     | 0.006363630294799805  | True       | 0                | 2              | 0                 | 4/4             |
| 05_multi_robot_conflict_through_waiting [Level 2]    | True             | True     | 0.005064487457275391  | True       | 0                | 0              | 0                 | 3/3             |
| 06_long_vertex_conflict [Level 2]                    | False            | True     | 0.0031931400299072266 | True       | 0                | 1              | 0                 | 2/2             |
| 07_marius_niklas_easy_center_conflict                | True             | True     | 0.0011637210845947266 | True       | 0                | 0              | 0                 | 2/2             |
| 08_marius_niklas_easy_conflict_square                | False            | True     | 0.003097057342529297  | True       | 0                | 1              | 0                 | 2/2             |
| 09_marius_niklas_easy_corridor                       | False            | True     | 0.003136873245239258  | True       | 0                | 1              | 0                 | 2/2             |
| 10_marius_niklas_easy_other_side                     | False            | True     | 0.0028433799743652344 | True       | 1                | 2              | 0                 | 3/3             |
| 13_marcus_max_3-robots_bench_test_10                 | False            | True     | 0.003228902816772461  | True       | 2                | 0              | 0                 | 3/3             |
| 14_marcus_max_3-robots_bench_test_11                 | False            | True     | 0.003083944320678711  | True       | 1                | 2              | 0                 | 3/3             |
| 15_marcus_max_3-robots_bench_test_12                 | False            | True     | 0.005106925964355469  | True       | 2                | 0              | 0                 | 3/3             |
| 16_marcus_max_3-robots_bench_test_13                 | False            | True     | 0.005408525466918945  | True       | 3                | 1              | 0                 | 3/3             |
| 17_marcus_max_3-robots_bench_test_14                 | False            | True     | 0.0045013427734375    | True       | 1                | 1              | 0                 | 3/3             |
| 18_marcus_max_4-robots_bench_test_15                 | True             | True     | 0.007200956344604492  | True       | 0                | 0              | 0                 | 4/4             |
| 19_marcus_max_4-robots_bench_test_15_mod             | False            | True     | 0.004689216613769531  | True       | 3                | 1              | 0                 | 4/4             |
| 20_multiple_dodges_necessary [Level 3]               | False            | True     | 0.001916646957397461  | True       | 0                | 1              | 0                 | 2/2             |



## Merger Version 3

| Instance Name                                        | Correct Solution | Solvable | Solving Time (in s)  | In Horizon | Vertex Conflicts | Edge Conflicts | Invalid Movements | Shelves Reached |
| ---------------------------------------------------- | ---------------- | -------- | -------------------- | ---------- | ---------------- | -------------- | ----------------- | --------------- |
| 01_vertex_constraint_benchmark [Level 1]             | True             | True     | 0.0249481201171875   | True       | 0                | 0              | 0                 | 2/2             |
| 02_edge_constraint_benchmark [Level 1]               | True             | True     | 0.029558420181274414 | True       | 0                | 0              | 0                 | 2/2             |
| 03_multi_robot_vertex_constraint_benchmark [Level 3] | True             | True     | 0.0581974983215332   | True       | 0                | 0              | 0                 | 4/4             |
| 04_multi_robot_edge_constraint_benchmark [Level 3]   | True             | True     | 0.051752567291259766 | True       | 0                | 0              | 0                 | 4/4             |
| 05_multi_robot_conflict_through_waiting [Level 2]    | True             | True     | 0.04245924949645996  | True       | 0                | 0              | 0                 | 3/3             |
| 06_long_vertex_conflict [Level 2]                    | False            | True     | 0.03013467788696289  | True       | 0                | 0              | 0                 | 1/2             |
| 07_marius_niklas_easy_center_conflict                | True             | True     | 0.007751941680908203 | True       | 0                | 0              | 0                 | 2/2             |
| 08_marius_niklas_easy_conflict_square                | True             | True     | 0.027146339416503906 | True       | 0                | 0              | 0                 | 2/2             |
| 09_marius_niklas_easy_corridor                       | True             | True     | 0.028753042221069336 | True       | 0                | 0              | 0                 | 2/2             |
| 10_marius_niklas_easy_other_side                     | True             | True     | 0.041066884994506836 | True       | 0                | 0              | 0                 | 3/3             |
| 13_marcus_max_3-robots_bench_test_10                 | True             | True     | 0.03988981246948242  | True       | 0                | 0              | 0                 | 3/3             |
| 14_marcus_max_3-robots_bench_test_11                 | True             | True     | 0.051302433013916016 | True       | 0                | 0              | 0                 | 3/3             |
| 15_marcus_max_3-robots_bench_test_12                 | True             | True     | 0.05042409896850586  | True       | 0                | 0              | 0                 | 3/3             |
| 16_marcus_max_3-robots_bench_test_13                 | True             | True     | 0.04549813270568848  | True       | 0                | 0              | 0                 | 3/3             |
| 17_marcus_max_3-robots_bench_test_14                 | True             | True     | 0.050870656967163086 | True       | 0                | 0              | 0                 | 3/3             |
| 18_marcus_max_4-robots_bench_test_15                 | True             | True     | 0.07107281684875488  | True       | 0                | 0              | 0                 | 4/4             |
| 19_marcus_max_4-robots_bench_test_15_mod             | False            | False    | 0.05870771408081055  | False      | 0                | 0              | 0                 | 0/0             |
| 20_multiple_dodges_necessary [Level 3]               | False            | False    | 0.017294645309448242 | False      | 0                | 0              | 0                 | 0/0             |



## Merger Version 4 and 5

| Instance Name                                        | Correct Solution | Solvable | Solving Time (in s)  | In Horizon | Vertex Conflicts | Edge Conflicts | Invalid Movements | Shelves Reached |
| ---------------------------------------------------- | ---------------- | -------- | -------------------- | ---------- | ---------------- | -------------- | ----------------- | --------------- |
| 01_vertex_constraint_benchmark [Level 1]             | True             | True     | 0.09051847457885742  | True       | 0                | 0              | 0                 | 2/2             |
| 02_edge_constraint_benchmark [Level 1]               | True             | True     | 0.15769100189208984  | True       | 0                | 0              | 0                 | 2/2             |
| 03_multi_robot_vertex_constraint_benchmark [Level 3] | True             | True     | 0.21567273139953613  | True       | 0                | 0              | 0                 | 4/4             |
| 04_multi_robot_edge_constraint_benchmark [Level 3]   | True             | True     | 0.23407864570617676  | True       | 0                | 0              | 0                 | 4/4             |
| 05_multi_robot_conflict_through_waiting [Level 2]    | True             | True     | 0.24103808403015137  | True       | 0                | 0              | 0                 | 3/3             |
| 06_long_vertex_conflict [Level 2]                    | True             | True     | 0.14520931243896484  | True       | 0                | 0              | 0                 | 2/2             |
| 07_marius_niklas_easy_center_conflict                | True             | True     | 0.040888071060180664 | True       | 0                | 0              | 0                 | 2/2             |
| 08_marius_niklas_easy_conflict_square                | True             | True     | 0.14957714080810547  | True       | 0                | 0              | 0                 | 2/2             |
| 09_marius_niklas_easy_corridor                       | True             | True     | 0.1374378204345703   | True       | 0                | 0              | 0                 | 2/2             |
| 10_marius_niklas_easy_other_side                     | True             | True     | 0.10537314414978027  | True       | 0                | 0              | 0                 | 3/3             |
| 13_marcus_max_3-robots_bench_test_10                 | True             | True     | 0.10913801193237305  | True       | 0                | 0              | 0                 | 3/3             |
| 14_marcus_max_3-robots_bench_test_11                 | True             | True     | 0.2325732707977295   | True       | 0                | 0              | 0                 | 3/3             |
| 15_marcus_max_3-robots_bench_test_12                 | True             | True     | 0.13908720016479492  | True       | 0                | 0              | 0                 | 3/3             |
| 16_marcus_max_3-robots_bench_test_13                 | True             | True     | 0.11188864707946777  | True       | 0                | 0              | 0                 | 3/3             |
| 17_marcus_max_3-robots_bench_test_14                 | True             | True     | 0.11424422264099121  | True       | 0                | 0              | 0                 | 3/3             |
| 18_marcus_max_4-robots_bench_test_15                 | True             | True     | 0.14110827445983887  | True       | 0                | 0              | 0                 | 4/4             |
| 19_marcus_max_4-robots_bench_test_15_mod             | True             | True     | 0.17509078979492188  | True       | 0                | 0              | 0                 | 4/4             |
| 20_multiple_dodges_necessary [Level 3]               | False            | False    | 0.045723915100097656 | False      | 0                | 0              | 0                 | 0/0             |
