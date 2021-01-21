# Approach 1

Merger encodings do not include benchmarks and should be run with a fitting benchmark and horizon. Expects input plans in the form of occurs1(...). Identical Versions with different instances are noted with \_N.

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
    + first tests on benchmark 2 successful
    + horizon moved to benchmarks
    

