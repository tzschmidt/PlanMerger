# Asprilo Benchmark Engine

### Requirements :

These packages are needed to execute the script:

+ numpy
+ matplotlib

they can be installed with `conda install numpy` and `conda install numpy`.

It is also required for the script to work that you use a Benchmark Structure that is similar to the one in this repo. Each Benchmark Folder has to therefore contain a folder named `full instance` which contains the Benchmarks instance with all robots and a folder called `plans` which only contains the basic plans for each robot (in one file ore multiple)



### Functionality :

The Benchmark Engine Script is able to automatically test multiple Asprilo Benchmark for common errors like:

+ Vertex Conflicts
+ Edge Conflicts
+ Time Horizon transgression
+ Invalid Movements



Functions planned to be added:

+ Clingo Execution Time tracking for the merger program
+ Clingo computation of the Merger initialised by the script for easier usability and easy time tracking



### Getting Started :

For an easy introduction into how to use the script read the `main.py` file. There should be all the functions needed to use the script. You can just modify the main.py script to adjust the script to your Purposes.