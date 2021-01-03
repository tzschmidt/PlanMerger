## Reevaluation of the first Ideas for plan merging

**Idea „Waiting“:**
Presented our Ideas and discussed their application, we came to the conclusion, that the Idea of waiting itself is quite useful to resolve the first types of collisions, but our Idea of using the distance to the respective goal as a priority turned out to be, at least for now, a bit to complex, so we will simply use the robot ID as our priority.

**Problem of the second type of collision:**
While our approach to create a new Path for one of the robots in the second type of collision turned out to be the right way forward, our Idea to flip the path or to create a new Path, where the other robot acts as a wall, turned out to be way to complex and could potentially cost to much time to compute.
A better Idea would be to generate a new path where one of the robots does a simple evasion move where it moves in one of the 4 cardinal directions and then immediately back to allow the other robot to go through. The robot would then proceed as usual.
This Idea is less complex and would allow the plan merger to solve a lot of second-type collisions (But still not all.)
