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

**Evaluation**

While Version 3 manages to solve roughly halve of the given benchmarks, it still struggles with two major problems:

    -When there are more than 2 robots, who interact with each other, the solver will not finish in a reasonable timeframe.
    -When we have a problem (like that in benchmark 6), where one of the robots has to wait long before the collision occurs, the merger will always tell us that the problem is “unsatisfiable”.

Both of these problems can’t, or are verry, verry difficult to solve with approach 2. 
The reason for this is, that the merger can only react when a collision occurs and has to create a new path with a higher collision depth each time to do so. This is on the one hand highly inefficient with a higher amount of interacting robots, and on the other hand can’t solve problems where the conflict can’t be solved with a wait or dodge directly at that timepoint (see Benchmark 6).

This shows us that this approach has a lot less potential than the newer approach (approach 1), which works on all benchmarks in a reasonable amount of time.
This older approach should nevertheless not be entirely discredited, because it is useful for a handful of different benchmarks and can solve these faster and also generates faster robot paths in some situations (like in Benchmark 2)
