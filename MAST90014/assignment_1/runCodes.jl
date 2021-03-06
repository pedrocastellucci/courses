# Executing this code will run the julia file with the implementation from students.
# The folders must be organized in a particular structure.
# This file must be in a parent folder containing a sub-folder called "instances",
# with all the problems that are going to be executed. Also, each student solution
# is within a sub-folder containing the substring "student_". In each "student_" sub-folder
# the code looks for a Julia (.jl) file and executed with two input parameters:
# input and output file. All the output files will be generated in the corresponding
# student sub-folder.


function getJuliaExecutable(folder)
	for filename in readdir(folder)
		if filename[end-2:end] == ".jl"
			return joinpath(folder, filename)
		end
	end

	println("Error processing folder $(folder)!. Julia exec not found!")
	exit(-1)
end


function runExecutables(instancesFolder, outputFolder, juliaExec)
	# println(instancesFolder)
	for inputfile in readdir(instancesFolder)

		outputfile = joinpath(outputFolder, inputfile[1:end-2] * "out")
		inputfile = joinpath(instancesFolder, inputfile)

		# We are skipping files that do not have the .in extension
		if inputfile[end-2:end] != ".in"
			continue
		end

		# println("Running julia $juliaExec $inputfile $outputfile")
		run(`julia $juliaExec $inputfile $outputfile`)

		outputfile = basename(inputfile)[1:end-2] * "out"
		outputfile = joinpath(outputFolder, outputfile)

		println(basename(juliaExec), " ",
				basename(inputfile), " ",
			 	basename(outputfile))

		cp(inputfile, outputfile)
	end
end

currentFolder = rstrip(Base.source_path(), ['r', 'u', 'n', 'C', 'o', 'd', 'e', 's', '.', 'j' ,'l'])

instancesFolder = joinpath(currentFolder, "instances")

for filename in readdir(currentFolder)
	if contains(filename, "student_")
		studentFolder = joinpath(currentFolder, filename)

		juliaExec = getJuliaExecutable(studentFolder)

		juliaExec = joinpath(studentFolder, juliaExec)

		runExecutables(instancesFolder, studentFolder, juliaExec)
	end
end

println("END")
