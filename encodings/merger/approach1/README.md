# Approach 1

Merger encodings do not include benchmarks and should be run with a  fitting benchmark and horizon. Expects input plans in the form of  occurs1(...). Identical Versions with different instances are noted with _N. Parameter #const horizon=10. needs to be set in the benchmarks or  be taken into account in the command. benchmark.lp files in this directory are only for testing and will be  removed later. For finished benchmarks check /instances/benchmarks/

- Version 1
  - Generates possible movement delays at different moments in time, if collisions were detected
  - Can not detect new collisions caused by waiting
  - !not complete/ does not run!
- Version 2
  - Same idea as Version 1
  - removes plans with new collisions
  - does not iterate until all collisions resolved, but chooces other  plan (could cause problems on plans with little possible wait variations
  - can solve vertex constraints (benchmarks 1 and 5)
  - TODO edge constraints
- Version 3
  - adds edge constraints to V2
  - merged plans seem unintuitive due to randomness
  - benchmark tests successful
  - horizon moved to benchmarks
- Version 4
  - additional features
  - locking: lock(object(robot,R)) in the benchmark causes this robot not ot deviate from its orignial plan
  - TODO A-domain: merger can merge M- and A-domain plans
- Version 5
  - A-domain: merger can merge M- and A-domain plans



| Instance Name                                       | Solving Time (in s)  | In Horizon | Vertex Conflicts | Edge Conflicts | Invalid Movements | Shelves Reached |
| --------------------------------------------------- | -------------------- | ---------- | ---------------- | -------------- | ----------------- | --------------- |
| 1_vertex_constraint_benchmark [Level 1]             | 0.030035972595214844 | True       | 0                | 0              | 0                 | 2/2             |
| 2_edge_constraint_benchmark [Level 1]               | 0.031919240951538086 | True       | 0                | 0              | 0                 | 2/2             |
| 3_multi_robot_vertex_constraint_benchmark [Level 3] | 0.06465721130371094  | True       | 0                | 0              | 0                 | 4/4             |
| 4_multi_robot_edge_constraint_benchmark [Level 3]   | 0.06262731552124023  | True       | 0                | 0              | 0                 | 4/4             |
| 5_multi_robot_conflict_through_waiting [Level 2]    | 0.058069467544555664 | True       | 0                | 0              | 0                 | 3/3             |
| 6_long_vertex_conflict [Level 2]                    | 0.0483551025390625   | True       | 0                | 0              | 0                 | 2/2             |
| RANDOM BENCHMARK 5X-5Y-11R                          | 0.30806446075439453  | True       | 0                | 0              | 0                 | 11/11           |
| RANDOM BENCHMARK 15X-15Y-50R                        | 25.171181678771973   | True       | 0                | 0              | 0                 | 50/50           |