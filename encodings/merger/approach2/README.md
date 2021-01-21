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