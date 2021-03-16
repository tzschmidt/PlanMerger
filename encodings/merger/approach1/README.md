# Approach 2

Currently (version 2) merger encodings include all needed instances and should be run alone. Identical Versions with different instances are noted with \_N.

- **Version 1**
    + Same as approach 1 version 1
- **Version 2**
    + Delays one robot if collision detected
    + Checks solutions for new crashes and fixes them through iterations
    + Does not fullfil Edge Constraints
    + Benchmark tests with instances 1 and 5 were successful
- **Version 3**
    + Does fullfil Edge Constraints if one of the 2 robots hase room to dodge
    + Edge constraint does not work when another robot blocks the dodge direction
    + Works for benchmark 1,2 and 5
    + Does not work for benchmark 3 and 4 (doesen't finish) and benchmark 6 (unsatisfiable)
    + still struggles with two major problems:
    	+ When there are more than 2 robots, who interact with each other, the solver will not finish in a reasonable timeframe.
    	+ When we have a problem (like that in benchmark 6), where one of the robots has to wait long before the collision occurs, the merger will always tell us that the problem is “unsatisfiable”.

For the next Versions we added a lot of benchmarks from other groups to see how well the programm would work in other situations

- **Version 4 to 6**
    + Versions 4 and 5 are incrementally improved versions of version 3 that worked on
      more benchmarks but still had some big issues which could largely be resolved in version 6 
    + While our last Version (mergeV6.lp) works on most Benchmarks it still hase a few issues:
    + There are a few benchmarks like "03_multi_robot_vertex_constraint_benchmark [Level 3]" 
      where our programm is verry slow
    + Benchmarks "06_long_vertex_conflict [Level 2]" and "20_multiple_dodges_necessary [Level 3]" 
      results in "unsatisfiable" but this is expected because our approach only reacts 
      when a collision occures, but in these benchmarks a robot has to wait/dodge long before the collision     
    + Our merge gives "unsatisfiable" for the verry similar benchmarks "16_marcus_max_3-robots_bench_test_13" and 
      "18_marcus_max_4-robots_bench_test_15"


**Evaluation**

While our initial assesment, that this first approach is inferior to our newer approach (approach 1), 
because it needs to keep track of the collision_depth for each position which makes the programm slower
and it can react only one timeframe before a collision occurs, which make some benchmakrs unsatisfiable,
we still managed to make this approch usefull for most of the given benchmarks, proving that this approch,
while inferior can still be usefull for a number of problems.