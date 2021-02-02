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

  defp generate_neighbors({x, y}, :keep), do: [{x,y}, {x+1, y}, {x-1, y}, {x, y+1}, {x, y-1}, {x+1, y+1}, {x-1, y+1}, {x+1, y-1}, {x-1, y-1}]
  defp generate_neighbors({x, y}), do: [{x+1, y}, {x-1, y}, {x, y+1}, {x, y-1}, {x+1, y+1}, {x-1, y+1}, {x+1, y-1}, {x-1, y-1}]
end
