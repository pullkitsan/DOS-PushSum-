defmodule Torus3D do
  def buildTorus3D(nodes) do
    numNodes = length(nodes)
    iter = :math.pow(numNodes,1/3) |> round()
    getNeighbours(nodes, iter)

  end

  def getNeighbours(nodes, iter) do
    last = iter - 1
    square_last = round(:math.pow(iter,2)) - 1
    cube_last = round(:math.pow(iter,3)) - 1

    for x <- 0..last, y <- 0..last, z <- 0..last do
      num_node = z + (y*iter) + (x* round(:math.pow(iter,2)))
      cond do
#-------------------------------------------------------Corners-------------------------------------------
        [x,y,z] == [0,0,0] ->
          neighbour_list = [num_node + 1,num_node + iter, num_node + round(:math.pow(iter,2)), last, round(:math.pow(iter,2)) - iter, cube_last - square_last] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)

        [x,y,z] == [0,0,last] ->
          neighbour_list = [num_node - 1, num_node + iter, num_node + round(:math.pow(iter,2)), 0, num_node + (cube_last - square_last), square_last] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)

        [x,y,z] == [0, last, 0] ->
          neighbour_list = [num_node + 1, num_node - iter, num_node + round(:math.pow(iter,2)), 0, num_node + last,  cube_last - last] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)

        [x,y,z] == [last,0,0] ->
          neighbour_list = [num_node + 1, num_node - round(:math.pow(iter,2)), num_node + iter, num_node + last, 0, cube_last - last] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)

        [x,y,z] == [last,last,0] ->
          neighbour_list = [num_node + 1, num_node - iter, num_node - round(:math.pow(iter,2)), num_node + last, square_last - last, cube_last - square_last] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)

        [x,y,z] == [last,0,last] ->
          neighbour_list = [num_node - 1, num_node + iter, num_node - round(:math.pow(iter,2)), cube_last - square_last, cube_last, last] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)

        [x,y,z] == [0,last,last] ->
          neighbour_list = [num_node - 1, num_node - iter, num_node + round(:math.pow(iter,2)), num_node - last, last, cube_last] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)

        [x,y,z] == [last,last, last] ->
          neighbour_list = [num_node - 1, num_node - iter, num_node - round(:math.pow(iter,2)), num_node - last, square_last, (cube_last - square_last) + last] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)

#-------------------------------------------Edges----------------------------------------------------------
        [x,z] == [0,0] ->
          neighbour_list = [num_node + 1, num_node - iter, num_node + iter, num_node + round(:math.pow(iter,2)), num_node + last, cube_last - square_last + num_node] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)

        [x,z] == [last,0] ->
          neighbour_list = [num_node + 1, num_node - iter, num_node + iter, num_node - round(:math.pow(iter,2)), num_node + last, square_last - (cube_last - num_node) ] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)

        [x,z] == [0,last] ->
          neighbour_list = [num_node - 1, num_node - iter, num_node + iter, num_node + round(:math.pow(iter,2)), num_node + (cube_last- square_last), num_node - last] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)

        [x,z] == [last,last] ->
          neighbour_list = [num_node - 1, num_node + iter, num_node - iter, num_node - round(:math.pow(iter,2)), num_node - last, square_last - (cube_last - num_node)] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)

        [x,y] == [0,0] ->
          neighbour_list = [num_node + 1, num_node - 1, num_node + iter, num_node + round(:math.pow(iter,2)), num_node + (cube_last - square_last), num_node + square_last - last] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)

        [x,y] == [0,last] ->
          neighbour_list = [num_node + 1, num_node - 1, num_node - iter, num_node + round(:math.pow(iter,2)), last - (square_last - num_node), cube_last - (square_last - num_node)] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)

        [x,y] == [last,0] ->
          neighbour_list = [num_node + 1, num_node - 1, num_node + iter, num_node - round(:math.pow(iter,2)), num_node - (cube_last - square_last), (cube_last - last) + (num_node - (cube_last - square_last))] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)

        [x,y] == [last,last] ->
          neighbour_list = [num_node + 1, num_node - 1, num_node - iter, num_node - round(:math.pow(iter,2)), num_node - (cube_last - square_last), (cube_last - square_last + last) - (cube_last - num_node)] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)

        [y,z] == [0,0] ->
          neighbour_list = [num_node + 1, num_node + iter, num_node + round(:math.pow(iter,2)), num_node - round(:math.pow(iter,2)), num_node + last, num_node - iter + round(:math.pow(iter,2))] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)

        [y,z] == [0,last] ->
          neighbour_list = [num_node - 1, num_node + round(:math.pow(iter,2)), num_node - round(:math.pow(iter,2)), num_node + iter, num_node - last, num_node - iter + round(:math.pow(iter,2))] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)

        [y,z] == [last,0] ->
          neighbour_list = [num_node + 1, num_node - iter, num_node + round(:math.pow(iter,2)), num_node - round(:math.pow(iter,2)), num_node + last, num_node - square_last + last] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)

        [y,z] == [last,last] ->
          neighbour_list = [num_node - 1, num_node - round(:math.pow(iter,2)), num_node + round(:math.pow(iter,2)), num_node - iter, num_node - last, num_node - square_last + last] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)

#--------------------------------------------------Faces----------------------------------------------
        [x] == [0] ->
          neighbour_list = [num_node - 1, num_node + 1, num_node + round(:math.pow(iter,2)), num_node + iter, num_node - iter, cube_last - square_last + num_node] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)

        [x] == [last] ->
          neighbour_list = [num_node + 1, num_node - 1, num_node - round(:math.pow(iter,2)), num_node + iter, num_node - iter, num_node - (cube_last - square_last)] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)

        [y] == [0] ->
          neighbour_list = [num_node + 1, num_node - 1, num_node + iter, num_node + round(:math.pow(iter,2)), num_node - round(:math.pow(iter,2)), num_node + (square_last - last)] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)

        [y] == [last] ->
          neighbour_list = [num_node + 1, num_node - 1, num_node + round(:math.pow(iter,2)), num_node - round(:math.pow(iter,2)), num_node - iter, num_node - (square_last + last)] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)

        [z] == [0] ->
          neighbour_list =[num_node + 1, num_node - iter, num_node + iter, num_node + last, num_node + round(:math.pow(iter,2)), num_node - round(:math.pow(iter,2))] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)

        [z] == [last] ->
          neighbour_list = [num_node - 1, num_node + iter, num_node - iter, num_node - last, num_node + round(:math.pow(iter,2)), num_node - round(:math.pow(iter,2))] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)
#-------------------------------------------General Case-------------------------------------------------------
        true ->
          neighbour_list = [num_node + 1, num_node - 1, num_node + iter, num_node - iter, num_node + round(:math.pow(iter,2)), num_node - round(:math.pow(iter,2))] #checked
          n_list = Enum.map(neighbour_list, fn x -> Enum.at(nodes,x) end)
          Proj2.add_to_adjList(Enum.at(nodes,num_node) ,n_list)



      end # condition end


    end# end for loop
  end #end getNeighbours

end
