# Generating random values as a solution. There is no guarantee of feasibility!

inputfile = ARGS[1]
outputfile = ARGS[2]

# For the assignment you MUST NOT add the following line to the file.
# println("Solution for file: $inputfile")

objValue = rand()*100

# This string will accumulate all the results that will be written in the output file:
solutionStr = "$objValue\n"

rows = 1:5
nodes = 1:20

for r in rows
	s, i, j = rand(nodes), rand(nodes), rand(nodes)

	# Adding one row to the file:
	solutionStr *= @sprintf("%d %d %d\n", s, i, j)
end

# Writing the file, if the file exists it will be overwritten:
open(outputfile, "w") do fd
	write(fd, solutionStr)
end
