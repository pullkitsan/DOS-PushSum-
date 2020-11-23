defmodule Proj2 do
  use GenServer
  def main(numNodes,topology,algo) do
    numNodes = if(topology == "3Dtorus") do
      cube_root = round(:math.pow(numNodes,1/3))
      _numNodes = cube_root * cube_root * cube_root
    else
      numNodes
    end
    #-----------------to form a complete honeycomb topology-------------------
    numNodes = if(topology =="honeycomb") do
      by_6 = round(numNodes/6)
      _numNodes = by_6 * 6
    else
      numNodes
    end
    numNodes = if(topology =="randhoneycomb") do
      by_6 = round(numNodes/6)
      _numNodes = by_6 * 6
    else
      numNodes
    end

    nodes = createnodes(numNodes)
    _table = createtable()
    cond do
      topology == "full" ->
        Topo.buildfullTopo(nodes)
      topology == "line" ->
        Topo.buildlineTopo(nodes)
      topology == "rand2D" ->
        Topo.buildRand2D(nodes)
      topology == "honeycomb" ->
        HComb.buildHoney(nodes)
      topology == "randhoneycomb" ->
        HComb.buildRandHoney(nodes)
      topology == "3Dtorus" ->
        Torus3D.buildTorus3D(nodes)
      true ->
        IO.puts("Enter a valid topology.")
        IO.puts("Valid topology inputs : full | line | rand2D | honeycomb | randhoneycomb | 3Dtorus")
        System.halt(0)
    end
    start_time = System.monotonic_time(:millisecond)
    cond do
      algo == "gossip" ->
        Algo.startGossip(nodes,start_time)
      algo == "pushsum" ->
        Algo.startPushSum(nodes,start_time)
        infinite_loop()
    end
  end
  def handle_cast({:pushsum,new_s,new_w,start_time, length},state) do
    {s,consecutive_count,adjList,w} = state
    this_s = s + new_s
    this_w = w + new_w
    diff = Algo.cal_diff(this_s,this_w,s,w)
    if(diff < :math.pow(10,-10) && consecutive_count==2) do
      count = :ets.update_counter(:table, "count", {2,1})
      if count == length do
        new_time = System.monotonic_time(:millisecond)
        end_time = new_time - start_time
        IO.puts "Convergence time = #{end_time} ms"
        System.halt(1)
      end
    end
    consecutive_count =
    if(diff < :math.pow(10,-10) && consecutive_count<2) do
      consecutive_count + 1
    else
      0
    end
    state = {this_s/2,consecutive_count,adjList,this_w/2}
    new_node = Enum.random(adjList)
    Algo.sendPushSum(new_node, this_s/2, this_w/2,start_time, length)
    {:noreply,state}
  end

    # def sendPushSum(new_node, this_s, this_w,start_time, length) do
    #   GenServer.cast(new_node, {:pushsum,this_s,this_w,start_time, length})
    # end
  def infinite_loop() do
    infinite_loop()
  end
  def createnodes(numNodes) do
     Enum.map((1..numNodes),fn(x) ->
      pid = start_node()
      updatestateof_pid(pid,x)
      pid
    end)
  end
  def createtable do
    table = :ets.new(:table, [:named_table, :public])
    :ets.insert(table, {"count" , 0})
  end

  def add_to_adjList(pid, list) do
    #IO.inspect list
    GenServer.call(pid, {:add_to_adjList, list})
  end

  def handle_call({:add_to_adjList, list} , _from, state) do
    {a,b,_c,d} = state
    state = {a,b,list,d}
    #IO.inspect state
    {:reply,a,state}
  end

  def start_node() do
    {:ok,pid} = GenServer.start_link(__MODULE__, :ok, [])
    pid
  end
  def init(:ok) do
    {:ok, {0,0,[],1}}
    #{nodeID, count, adjacentList}
  end
  def updatestateof_pid(pid, nodeID) do
    GenServer.call(pid, {:updatestateof_pid, nodeID})
  end
  def handle_call({:updatestateof_pid,nodeID},__from, state) do
    {a,b,c,d} = state
    state = {nodeID,b,c,d}
    {:reply, a, state}
  end

  def getAdjacentList(pid) do
    GenServer.call(pid,{:getAdjacent})
  end

  def handle_call({:getAdjacent}, _from, state) do
    {_a,_b,c,_d} = state
    {:reply, c, state}
  end

  def getcount(pid) do
    GenServer.call(pid,{:getcount})
  end
  def handle_call({:getcount}, _from, state) do
    {_a,b,_c,_d} = state
    {:reply, b, state}
  end

  def updatecount(pid,start_time,length) do
    GenServer.call(pid, {:updatecount, start_time,length})
  end
  def handle_call({:updatecount,start_time,length}, _from, state) do
    {a,b,c,d} = state
    if(b == 0) do
      count = :ets.update_counter(:table, "count", {2,1})
      if(count == length) do
      end_time = System.monotonic_time(:millisecond) - start_time
      IO.puts "Convergence time = #{end_time} ms"
      System.halt(1)
      end
    end
    state = {a,b+1,c,d}
    {:reply,b+1,state}
  end
end
