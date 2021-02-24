# Approach 1

Merger encodings do not include benchmarks and should be run with a fitting benchmark and horizon. Expects input plans in the form of occurs1(...). Identical Versions with different instances are noted with \_N. Parameter "#const horizon=10." needs to be set in the benchmarks or be taken into account in the command. For A-domain benchmarks "adomain." must be set in the benchmark. 
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
    + multiple robots are not allowed to access the same shelf in their original plans
    + benchmarks must contain "adomain." 

