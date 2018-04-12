# The City Logistics Travelling Salesman Problem

In this folder, you will find:

- [The open instances which are used for grading.](instances/)
- [Julia script for running students' codes and example of the folders structure.](runCodes.jl)
- [An example on how to read the input parameters and save an output file.](student_1/student_id.jl)


## Details on folder structure for automatic running students' code

Consider a parent folder, in which file [*runCodes.jl*](runCodes.jl) is placed. For the script to run correctly, we need a sub-folder for *instances* with each of the problems that will be given as input parameter for the student code. Also, there is a sub-folder associated with each student (*student folder*). Each *student folder*, must contain the student submitted Julia file (*.jl*).  It must be the only file with the *.jl* extension.

Before the execution of  [*runCodes.jl*](runCodes.jl), the folder tree should like the following diagram.

<pre>
parent folder/
├── instances/
│   ├── problem_1.in
│   ├── problem_2.in
│   ├── problem_3.in
│   └── problem_4.in
├── student_1/
│   └── student_id.jl
├── student_2/
│   └── student_id.jl
├── student_3/
│   └── student_id.jl
└── runCodes.jl
</pre>

After the execution of  [*runCodes.jl*](runCodes.jl), for each student, a solution file for each of the instances will be created inside the folder associated with that student. Therefore, the folder tree will look like the following. Possibly with some garbage in *instances* folder 

<pre>
parent folder/
├── instances/
│   ├── problem_1.in
│   ├── problem_2.in
│   ├── problem_3.in
│   └── problem_4.in
├── student_1/
│   ├── student_id.jl
│   ├── problem_1.out
│   ├── problem_2.out
│   ├── problem_3.out
│   └── problem_4.out
├── student_2/
│   ├── student_id.jl
│   ├── problem_1.out
│   ├── problem_2.out
│   ├── problem_3.out
│   └── problem_4.out
├── student_3/
│   ├── student_id.jl
│   ├── problem_1.out
│   ├── problem_2.out
│   ├── problem_3.out
│   └── problem_4.out
└── runCodes.jl
</pre>

