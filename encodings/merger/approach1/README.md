# Approach 1

At the moment (version 2) merger encodings include all needed instances and should be run alone. Identical Versions with different instances are noted with \_N.

- **Version 1**
    + Generates possible movement delays at different moments in time, if collisions were detected
    + Can not detect new collisions caused by waiting
    + !not complete/ does not run!
- **Version 2**
    + Same idea as Version 1
    + removes plans with new collisions
    + does not iterate until all collisions resolved, but chooces other plan (could cause problems on plans with little possible wait variations
    + can solve vertex constraints
    + TODO edge constraints
- **Version 3**
    + tries to add edge constraints to V2
    + WIP
    

