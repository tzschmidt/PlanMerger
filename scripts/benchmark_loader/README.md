# Benchmark Loader Script - [Python]

The Benchmark Loader Script is used to easily import the compressed versions our benchmarks into our current working directory or to any other directory we want.

## What it Does:

The Script concatenates all the separate robot plans and the instance of a benchmark into one file (standard `out.lp`) and stores this file in any directory you want or outputs the code in the terminal. Additionally a separate `instance.lp` file is generated which contains only the benchmarks instance for an easy way to visualise.

## How to use:

To start the script you just have to execute the `main.py` file. 

```
python3 .../scripts/benchmark_loader/main.py
```

The following options are possible:

+ `-n [output name]` : name the output file 
+ `-f` : store the output in a file
  + `-d [directory]` : specify the directory in which the output file is saved before runtime

## Details:

+ written in Python 3.7
+ works on Linux(Ubuntu)
+ Windows not yet tested