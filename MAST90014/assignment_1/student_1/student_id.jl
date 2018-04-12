using JuMP
using Cbc


function readData(filename)
	data = readcsv(filename)

	nSuppliers, nConsumers = data[1,1:2]
	posMatrixAux = data[3:3+nSuppliers+nConsumers, 2:3]
	dMatrixAux = data[3+nSuppliers:3+nSuppliers+nConsumers-1, 4:4+nSuppliers-1]

	suppliers = 1:nSuppliers
	consumers = nSuppliers+1:nSuppliers + nConsumers
	warehouse = nSuppliers + nConsumers + 1: nSuppliers + nConsumers +1
	nodes = 1:warehouse[end]

	posX = Dict{Int, Float64}()
	posY = Dict{Int, Float64}()
	for i in nodes
		posX[i] = posMatrixAux[i,1]
		posY[i] = posMatrixAux[i,2]
	end

	cost = Dict{Tuple{Int, Int}, Float64}()
	for i in nodes, j in nodes
		cost[i, j] = sqrt((posX[i] - posX[j])^2 + ( posY[i] - posY[j])^2)
	end

	demand = Dict{Tuple{Int, Int}, Int}()
	for (i, c) in enumerate(consumers), (j, s) in enumerate(suppliers)
		demand[c, s] = dMatrixAux[i, j]
	end

	suppliers, consumers, warehouse, nodes, posX, posY, cost, demand
end

# Using ARGS[1], means that the file name will be read from the first
# argument of the command-line.
inputfile = ARGS[1]
suppliers, consumers, warehouse, nodes, posX, posY, cost, demand = readData(inputfile)

# The following model does NOT solve the assigment problem.
m = Model(solver=CbcSolver(sec=300))
@variable(m, x[nodes, nodes, suppliers], Bin)
@objective(m, Min, sum(cost[i, j] * x[i, j, s] for i in nodes, j in nodes, s in suppliers))
@constraint(m, [j in consumers, s in suppliers], sum(x[i, j, s] for i in nodes) == demand[j, s])
@constraint(m, [i in nodes, s in suppliers], x[i, i, s] == 0)
solve(m)

toPrint = "$(getobjectivevalue(m))\n"

for s in suppliers, i in nodes, j in nodes
    if getvalue(x[i, j, s]) > 0.001
        toPrint *= "$s $i $j\n"
    end
end

# println(toPrint)
outputfile = inputfile[1:end-2] * "out"

open(outputfile, "w") do fd
	write(fd, toPrint)
end
