# Plan merger Encodings

This directory will include several iterations and versions of our plan merger implementation.

At the moment (version 2) merger encodings include all needed instances and should be run alone. Identical Versions with different instances are noted with \_N.

- **Version 1**
    + Generates possible movement delays at different moments in time, if collisions were detected
    + Can not detect new collisions caused by waiting
    + !not complete/ does not run! 
- **Version 2**
    + Delays one robot if collision detected
    + Checks solutions for new crashes and fixes them through iterations
    + Does not fullfil Edge Constraints
    + Benchmark tests with instances 1 and 5 were succesful


