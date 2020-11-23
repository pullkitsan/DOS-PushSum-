defmodule HComb do
  def buildHoney(nodes) do
    numNodes = length(nodes)
    row_x = numNodes/6 |> round()

    getNeighbours(nodes,numNodes, row_x)
end

  def getNeighbours(nodes, _numNodes, row_x) do
    list_neighbours = []
    end_level = row_x - 1



    for x <- 0..end_level, y <- 0..5 do
      equation = y + (6*x)
      cond do
#----------------------First Row----------------------------------------------------------------
        x == 0 ->
          if rem(y,2) == 0 do
            list_neighbours = list_neighbours ++ [Enum.at(nodes,equation + 1), Enum.at(nodes,equation + 6)]
            Proj2.add_to_adjList(Enum.at(nodes,equation) ,list_neighbours)
          else
            list_neighbours = list_neighbours ++ [Enum.at(nodes,equation - 1), Enum.at(nodes,equation + 6)]
            Proj2.add_to_adjList(Enum.at(nodes,equation) ,list_neighbours)
          end
 #-----------------------last row----------------------------------------------------------------
        x == (end_level) ->
          if rem(x,2) == 0 do
            if rem(y,2) == 0 do
              list_neighbours = list_neighbours ++ [Enum.at(nodes,equation + 1), Enum.at(nodes,equation - 6)]
              Proj2.add_to_adjList(Enum.at(nodes,equation) ,list_neighbours)
            else
              list_neighbours = list_neighbours ++ [Enum.at(nodes,equation - 1), Enum.at(nodes,equation - 6)]
              Proj2.add_to_adjList(Enum.at(nodes,equation) ,list_neighbours)
            end

          else
            if rem(x,2) == 1 do
              if y == 0 or y == 5 do
                list_neighbours = [Enum.at(nodes, equation - 6)]
                Proj2.add_to_adjList(Enum.at(nodes,equation) ,list_neighbours)
              else
                if rem(y,2) == 1 do
                  list_neighbours = list_neighbours ++ [Enum.at(nodes,equation + 1), Enum.at(nodes,equation - 6)]
                  Proj2.add_to_adjList(Enum.at(nodes,equation) ,list_neighbours)
                else
                  list_neighbours = list_neighbours ++ [Enum.at(nodes,equation - 1), Enum.at(nodes,equation - 6)]
                  Proj2.add_to_adjList(Enum.at(nodes,equation) ,list_neighbours)
                end
              end
            end
          end

#---------------------General Case---------------------------------------------------------------

        rem(x,2) == 0 and (x > 0 or x < end_level) ->
          if rem(y,2) == 0 do
            list_neighbours = list_neighbours ++ [Enum.at(nodes, equation + 1), Enum.at(nodes, equation + 6), Enum.at(nodes, equation - 6)]
            Proj2.add_to_adjList(Enum.at(nodes,equation) ,list_neighbours)
          else
            list_neighbours = list_neighbours ++ [Enum.at(nodes, equation - 1), Enum.at(nodes, equation + 6), Enum.at(nodes, equation - 6)]
            Proj2.add_to_adjList(Enum.at(nodes,equation) ,list_neighbours)
          end
        rem(x,2) == 1 and (x > 0 or x < end_level) ->
          if y==0 or y==5 do
            list_neighbours = list_neighbours ++ [Enum.at(nodes, equation + 6), Enum.at(nodes, equation - 6)]
            Proj2.add_to_adjList(Enum.at(nodes,equation) ,list_neighbours)
          else
            if rem(y,2) == 0 do
              list_neighbours = list_neighbours ++ [Enum.at(nodes, equation - 1), Enum.at(nodes, equation + 6), Enum.at(nodes, equation - 6)]
              Proj2.add_to_adjList(Enum.at(nodes,equation) ,list_neighbours)
            else
              list_neighbours = list_neighbours ++ [Enum.at(nodes, equation + 1), Enum.at(nodes, equation + 6), Enum.at(nodes, equation - 6)]
              Proj2.add_to_adjList(Enum.at(nodes,equation) ,list_neighbours)
            end
          end


      end #cond end
    end #for end
  end

  def buildRandHoney(nodes) do
    numNodes = length(nodes)
    row_x = numNodes/6 |> round()

    getRandNeighbours(nodes,numNodes, row_x)
  end

  def getRandNeighbours(nodes, _numNodes, row_x) do
    list_neighbours = []
    end_level = row_x - 1


    for x <- 0..end_level, y <- 0..5 do
      equation = y + (6*x)
      cond do
  #----------------------First Row----------------------------------------------------------------
        x == 0 ->
          if rem(y,2) == 0 do
            list_neighbours = list_neighbours ++ [Enum.at(nodes,equation + 1), Enum.at(nodes,equation + 6), Enum.at(nodes, Enum.random(0..end_level))]
            Proj2.add_to_adjList(Enum.at(nodes,equation) ,list_neighbours)
          else
            list_neighbours = list_neighbours ++ [Enum.at(nodes,equation - 1), Enum.at(nodes,equation + 6), Enum.at(nodes, Enum.random(0..end_level))]
            Proj2.add_to_adjList(Enum.at(nodes,equation) ,list_neighbours)
          end
  #-----------------------last row----------------------------------------------------------------
        x == (end_level) ->
          if rem(x,2) == 0 do
            if rem(y,2) == 0 do
              list_neighbours = list_neighbours ++ [Enum.at(nodes,equation + 1), Enum.at(nodes,equation - 6), Enum.at(nodes, Enum.random(0..end_level))]
              Proj2.add_to_adjList(Enum.at(nodes,equation) ,list_neighbours)
            else
              list_neighbours = list_neighbours ++ [Enum.at(nodes,equation - 1), Enum.at(nodes,equation - 6), Enum.at(nodes, Enum.random(0..end_level))]
              Proj2.add_to_adjList(Enum.at(nodes,equation) ,list_neighbours)
            end

          else
            if rem(x,2) == 1 do
              if y == 0 or y == 5 do
                list_neighbours = [Enum.at(nodes, equation - 6), Enum.at(nodes, Enum.random(0..end_level))]
                Proj2.add_to_adjList(Enum.at(nodes,equation) ,list_neighbours)
              else
                if rem(y,2) == 1 do
                  list_neighbours = list_neighbours ++ [Enum.at(nodes,equation + 1), Enum.at(nodes,equation - 6), Enum.at(nodes, Enum.random(0..end_level))]
                  Proj2.add_to_adjList(Enum.at(nodes,equation) ,list_neighbours)
                else
                  list_neighbours = list_neighbours ++ [Enum.at(nodes,equation - 1), Enum.at(nodes,equation - 6), Enum.at(nodes, Enum.random(0..end_level))]
                  Proj2.add_to_adjList(Enum.at(nodes,equation) ,list_neighbours)
                end
              end
            end
          end

  #---------------------General Case---------------------------------------------------------------

        rem(x,2) == 0 and (x > 0 or x < end_level) ->
          if rem(y,2) == 0 do
            list_neighbours = list_neighbours ++ [Enum.at(nodes, equation + 1), Enum.at(nodes, equation + 6), Enum.at(nodes, equation - 6), Enum.at(nodes, Enum.random(0..end_level))]
            Proj2.add_to_adjList(Enum.at(nodes,equation) ,list_neighbours)
          else
            list_neighbours = list_neighbours ++ [Enum.at(nodes, equation - 1), Enum.at(nodes, equation + 6), Enum.at(nodes, equation - 6), Enum.at(nodes, Enum.random(0..end_level))]
            Proj2.add_to_adjList(Enum.at(nodes,equation) ,list_neighbours)
          end
        rem(x,2) == 1 and (x > 0 or x < end_level) ->
          if y==0 or y==5 do
            list_neighbours = list_neighbours ++ [Enum.at(nodes, equation + 6), Enum.at(nodes, equation - 6), Enum.at(nodes, Enum.random(0..end_level))]
            Proj2.add_to_adjList(Enum.at(nodes,equation) ,list_neighbours)
          else
            if rem(y,2) == 0 do
              list_neighbours = list_neighbours ++ [Enum.at(nodes, equation - 1), Enum.at(nodes, equation + 6), Enum.at(nodes, equation - 6), Enum.at(nodes, Enum.random(0..end_level))]
              Proj2.add_to_adjList(Enum.at(nodes,equation) ,list_neighbours)
            else
              list_neighbours = list_neighbours ++ [Enum.at(nodes, equation + 1), Enum.at(nodes, equation + 6), Enum.at(nodes, equation - 6), Enum.at(nodes, Enum.random(0..end_level))]
              Proj2.add_to_adjList(Enum.at(nodes,equation) ,list_neighbours)
            end
          end


      end #cond end
    end #for end


  end

end
