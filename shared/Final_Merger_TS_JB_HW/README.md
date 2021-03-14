# Python Merger Script

This python script `main.py` represents the merger of our group (Tom S., Julian B., Hannes W.). Its use is basically only to minimise the solution horizon by iterating over all possible horizons until it finds an optimal solution. The whole rest of the merging process is done by our merging script `final_M_merger.lp` which is written in ASP.



## Requirements

The only requirement for this script to work is a working installation of `clingo`

+ If you don't have clingo installed you can look at the installation process here : https://potassco.org/clingo/
+ If you should have problems even though you have `clingo` installed you might have to change your python (or conda) virtual environment to the one where `clingo` is installed



## Usage

You can simply execute the script for a command line just like :

```bash
python3 main.py
```

Though it is necessary to forward the script the instance and plan files for the benchmark to be computed.

You can just simply, in clingo style, append the file names at the end of your script call. For example like this:

```bash
python3 main.py instance.lp plans.lp
```

It is not necessary to separate instance and plans it is only required that in all the files that are passed the plans and the instance are contained in some way.



## Output

+ The script will, while iterating through the horizon-space, give you visual feedback to show where the search is at currently.
+ if there is a possible solution (that can be found by our solver) the script will show you the smallest possible horizon and two solving times
+ the first solving time `(full search)` is the time that it takes to iterate over the horizons and to solve for each one until a satiable solution is found
+ the second solving time `(single solvable instance)` is the solving time for only the satiable solution if one can be found

