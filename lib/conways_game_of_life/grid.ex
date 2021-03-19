defmodule Grid do

  def new() do
   [ {5,6}, {6,6}, {7,6},
            {6,7},

                              {35,30}, {36,30}, {37,30},
                              {35,31},
                                       {36, 32}]
  end

  def turn(alive_points) do
    alive_points
    |> Enum.map(fn {x,y} -> generate_neighbors({x,y}, :keep) end)
    |> Enum.concat
    |> Enum.uniq
    |> Enum.filter(fn {x,y} -> alive?(alive_points, {x,y}) end)
  end

  def alive?(alive_points, point) do
    status = point in alive_points

    number_of_neighbors =
      alive_points
      |> Enum.filter(fn p -> p in generate_neighbors(point) end)
      |> length

    case {number_of_neighbors, status} do
      {3, true} -> true
      {3, false} -> true
      {2, true} -> true
      _ -> false
    end
  end

  # still life pattern
  def loaf({x,y}) do
    [       {1,0}, {2,0},
      {0,1},             {3,1},
      {0,2},       {2,2},
            {1,3}]
    |> move({x,y})
  end

  #oscillator pattern
  def blinker({x,y}) do
    [ {0,0}, {1,0}, {2,0} ]
    |> move({x,y})
  end

  #oscillator pattern
  def pulsar({x,y}) do
    [              {2,0}, {3,0}, {4,0},
      {0,1},                            {5,1},
      {0,2},                            {5,2},
      {0,3},                            {5,3},

                   {2,5}, {3,5}, {4,5}]
    |> move({x,y})
  end

  #spaceship pattern
  def glider({x,y}) do
    [{0,0}, {1,0}, {2,0},
                   {2,1},
            {1,2}]
    |> move({x,y})
  end

  #spaceship pattern
  def lightweight_space_ship({x,y}) do
    [       {1,0},               {4,0},
      {0,1},
      {0,2},                     {4,2},
      {0,3}, {1,3}, {2,3}, {3,3}]
    |> move({x,y})
  end

  defp move(points, {delta_x, delta_y}), do: Enum.map(points, fn {x, y} -> {x + delta_x, y + delta_y} end)

  defp generate_neighbors({x, y}, :keep), do: [{x,y}, {x+1, y}, {x-1, y}, {x, y+1}, {x, y-1}, {x+1, y+1}, {x-1, y+1}, {x+1, y-1}, {x-1, y-1}]
  defp generate_neighbors({x, y}), do: [{x+1, y}, {x-1, y}, {x, y+1}, {x, y-1}, {x+1, y+1}, {x-1, y+1}, {x+1, y-1}, {x-1, y-1}]
end
