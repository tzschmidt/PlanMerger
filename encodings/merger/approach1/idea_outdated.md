# ASP Plan Merger V2 Layout

[TOC]

## Input :

+ Independently generated Robot plans
+ max_time horizon



## Generation :

+ for each robot plan generate versions that:
  + have waits (also multiple in a row) at any point of the robots plan.
  + have evasive maneuvers in multiple directions (maybe multiple in a row) at any point of the robots plan 

```
horzion = 5

W  - S1 - S2 - S3
W  - S1 - W  - S2 - S3
W  - W  - S1 - S2 - S3
```



## Constraints :

+ don't allow plans that have collisions
+ don't allow plans that are over the time horizon
+ impossible maneuvers



## Output :

