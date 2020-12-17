# PlanMerger

## About

Our PlanMerger tries to find effective and cost efficient solutions for collisions in Multi-Agent-Pathfinding.
To improve scalablity and performance the problem instance with multiple agents will be divided into multiple instances with one agent each.
These instances are solved by a solver separately and subsequently merged into the final solution.


### Build with

As basis and benchmark framework we use [asprilo](https://asprilo.github.io/).
Asprilo supports many benchmark scenarios, but for the sake of simplicity we will focus on the m-domain of the instances, so only on the movement of the agents/robots.
Further implementations will be done with Python or Anser Set Programming, specifically [clingo](https://potassco.org/clingo/).


## Directory Structure

- './encodings/m/' contains all encodings for the m-domain
- './encodings/merger/' contains different encoding versions for the plan merger
- './instances/benchmarks/' contains benchmark instances which are used for testing the plan merger encodings


## Contact

- Tom Schmidt tom.schmidt@uni-potsdam.de
- Hannes Weichelt hannes.weichelt@uni-potsdam.de
- Julian Bruns julian.bruns@uni-potsdam.de

