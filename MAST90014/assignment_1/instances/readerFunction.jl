
function readData(filename)

    # This function reads the data from a file and returns the data used
	# for the problem. The parameter of the function is a string with
	# the path for the file (e. g. data.csv) which has the data for the problem.
	# The return of the function is a list with:
	# suppliers: a collection with the suppliers.
	# consumers: a collection with the consumers.
	# warehouses: a collection with the warehouses.
	# nodes: a collection with all the nodes in the network.
	# posX: a dictionary mapping a node (int) to its x-axis coordinate.
	# posY: a dictionary mapping a node (int) to its y-axis coordidate.
	# cost: cost[i, j], the distance between node i and j.
	# demand: demand[c, s], binary parameter indicating if consumer c demands
	#         products from supplier s

	data = readcsv(filename)

	# Suppliers and consumers and in the first row:
	nSuppliers, nConsumers = data[1,1:2]

	# Second and third columns are x and y positions:
	posMatrixAux = data[3:3+nSuppliers+nConsumers, 2:3]

	# Remaining columns (excluding 3+nSuppliers first rows) have binary
	# parameter indicating if consumer c demands products from supplier s:
	dMatrixAux = data[3+nSuppliers:3+nSuppliers+nConsumers-1, 4:4+nSuppliers-1]

	# Collect of suppliers:
	suppliers = 1:nSuppliers

	# Collection of consumers:
	consumers = nSuppliers+1:nSuppliers + nConsumers

	# Collection of warehouses:
	warehouse = nSuppliers + nConsumers + 1: nSuppliers + nConsumers +1

	# Collection of all nodes:
	nodes = 1:warehouse[end]

	# Dictionary of x and y positions of each node:
	posX = Dict{Int, Float64}()
	posY = Dict{Int, Float64}()
	for i in nodes
		posX[i] = posMatrixAux[i,1]
		posY[i] = posMatrixAux[i,2]
	end

	# Cost, distance, between each pair of nodes:
	cost = Dict{Tuple{Int, Int}, Float64}()
	for i in nodes, j in nodes
		cost[i, j] = sqrt( (posX[i] - posX[j])^2 + ( posY[i] - posY[j])^2)
	end

	# Dictionary with the demands. We are adjusting the indexes of
	# supplier of the dMatrixAux, previously defined
	demand = Dict{Tuple{Int, Int}, Int}()
	for (i, c) in enumerate(consumers), (j, s) in enumerate(suppliers)
		demand[c, s] = dMatrixAux[i, j]
	end

	# Returns:
	suppliers, consumers, warehouse, nodes, posX, posY, cost, demand
end

println(pwd())
a = readData("assignment_1/instances/out.out")
println(a)
