## First Idea for plan merging

There are two types of collisions between robots we have to keep in mind:
1. Multiple robots are at the same space and at the same time.
2. Two robots want to go through each other.

**Idea „Waiting“:**
(Waiting in this case means, that the time value of each following movement of the robot is incremented by one.)
In the case a collision occurs, one of the robots could simply wait. To decide which one of the robots should wait we could use certain priorities. One idea for priority is to use the robot ID, so that the robot with a lower ID has to wait.
Another Idea would be to use the distance to the shelve of the robots as a measurement of priority, so that the robot who is further away form their respective goal has to wait. We do this to “boost” robots who are already close to their goal, because robots who are on their respective shelve don’t move much and as such, are much less likely to inhibit other robots. In case that multiple robots have the same priority, we would simply use the ID again.


**Problem of the second type of collision:** A big problem we are still facing is that the “waiting” – Idea only really works for the first type of collision but not the second one, in which two robots want to get past each other. In that case one of the robots would wait, but the other robot still couldn’t go through the waiting robot. The only real choice we have is to generate a new path for one of the robots. 

**Idea „New path with a new obstacle“:** To solve this new problem we could generate a new path for the robot with higher priority in a similar way that the first paths of the robots hade been created. The only difference now is that for this new path the other robot (with lower ID) would act like a wall. This would force the robot with higher priority to go around the other robot and both robots wouldn’t try to go through each other any more.

**Idea „Flipping the path“:** Lastly, we could also try, if possible to simply flip or mirror the path of one of the robots on a certain axis. For example if we had a robot that hade to go up “n” tiles and then right “m” tiles, we could if this would create a collision simply flip that path so that the robot goes first “m” tiles to the right and then “n” tiles up. This would obviously only work if the flipped path would result in new collisions with other robots or with a wall.
