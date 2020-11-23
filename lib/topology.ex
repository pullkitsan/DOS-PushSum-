defmodule Topo do

#-------------------------------------Rand2D-------------------------------------
def create_array(length, list \\ []) do
  if length == 0 do
    list
else
  length-1 |> create_array([:rand.uniform() |> Float.round(2) | list])
end
end

def checkNeighbours(c, p) do
  {a, b} = p
  {p, q} = c
  first = :math.pow((a-p), 2)
  last = :math.pow((b-q), 2)
  radii = :math.pow(first + last, 1/2)
  if radii <= 0.1 and radii > 0 do
    true
  else
    false
  end
end
def create_coordinates(nodes) do
  length = Enum.count(nodes)
  x = create_array(length)
  y = create_array(length)
  _coordinates = Enum.zip(x, y)
end

def buildRand2D(nodes) do
  list = create_coordinates(nodes)
  Enum.each(nodes, fn x ->
    i = Enum.find_index(nodes, fn b -> b == x end)
    c = Enum.fetch!(list, i)
    num_nodes = Enum.count(nodes)
    n_list = Enum.filter((0..num_nodes-1), fn y -> checkNeighbours(c, Enum.at(list, y)) end)
    adjlist = Enum.map_every(n_list, 1, fn x -> Enum.at(nodes, x) end)
    Proj2.add_to_adjList(x,adjlist)
  end)
end

#----------------------------------------------Line-------------------------------------
def buildlineTopo(nodes) do
  num_nodes = length(nodes)
  start = 0

  end_val = (num_nodes - 1)
  new_list = Enum.each(nodes, fn(x) ->
    index = Enum.find_index(nodes,fn(i) -> i==x end)
    adjlist = []
    cond do
      index < end_val && index > start ->
        n1 = Enum.at(nodes,index-1)
        n2 = Enum.at(nodes,index+1)
        adjlist = adjlist ++ [n1,n2]
        Proj2.add_to_adjList(x,adjlist)
        # IO.inspect adjlist
      index < start + 1 ->
        n2 = Enum.at(nodes,index+1)
        adjlist = adjlist ++ [n2]
        Proj2.add_to_adjList(x,adjlist)
        # IO.inspect adjlist
      true->
        n1 = Enum.at(nodes,index-1)
        adjlist = adjlist ++ [n1]
        Proj2.add_to_adjList(x,adjlist)
        # IO.inspect adjlist
    end
  end)
  new_list
end

#-----------------------------------Full Topology------------------------------------
def buildfullTopo(nodes) do
  Enum.each(nodes, fn(x) ->
    adjlist = List.delete(nodes,x)
    Proj2.add_to_adjList(x,adjlist)
  end)
end

end
