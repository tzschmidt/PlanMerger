# Asprilo Benchmark Engine

### Requirements :

These packages are needed to execute the script:

+ numpy
+ matplotlib
+ clingo

they can be installed with `conda install numpy` and `conda install numpy` (for the clingo installation process consult https://potassco.org/doc/start/).

It is also required for the script to work that you use a Benchmark Structure that is similar to the one in this repo. Each Benchmark Folder has to therefore contain a folder named `full instance` which contains the Benchmarks instance with all robots and a folder called `plans` which only contains the basic plans for each robot (in one file ore multiple)

**Necessary Benchmark Directory Structure:**

```
Benchmark Folder
├── full_instance
│   └── [instance_name].lp
├── plans
│	├── [plan_robot_1_name].lp
│	├── [plan_robot_2_name].lp
│	│	+ (only one plan file for all robot plans is also possible)
│	│	+ (ideally there are no other files in this directory)
│	└── ...
└── ...
```



### Functionality :

The Benchmark Engine Script is able to automatically test multiple Asprilo Benchmark for common errors like:

+ Vertex Conflicts
+ Edge Conflicts
+ Time Horizon transgression
+ Invalid Movements

+ Clingo Execution Time tracking for the merger program
+ Clingo computation of the Merger + Benchmark initialised by the script for easier usability and easy time tracking



### Getting Started :

For an easy introduction into how to use the script read the `main.py` file. There should be all the functions needed to use the script. You can just modify the main.py script to adjust the script to your Purposes.