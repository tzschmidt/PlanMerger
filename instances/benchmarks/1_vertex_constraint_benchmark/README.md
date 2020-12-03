# Benchmark 1 - Vertex Constraint



## Description

With this benchmark we try to tackle the **vertex constraint** problem of our plan merger. This occurs when two robots try to enter the same node at the same time (illustrated in _Image_1_). In a real life scenario this would result in a crash of the two robots. 



Image_1 :  Vertex Constraint Conflict

![ Vertex Constraint Problem](vertex_constraint.png "Vertex Constraint Conflict") 



To invoke this conflict we have created a map in which there are two, equally long, crossing corridors, which each have a robot on one end and a shelve with a product on the other. If both robots would just go straight forward for the selves they would crash in the middle (vertex constraint).



Image_2: Map View of Benchmark 1

![Map view of Benchmark 1](x5_y5_n9_r2_s2_ps1_pr2_u2_o2_l0_N001.png "Map view of Benchmark 1") 

