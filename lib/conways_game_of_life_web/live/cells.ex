defmodule ConwaysGameOfLifeWeb.Cells do
  use ConwaysGameOfLifeWeb, :live_component

  def render(assigns) do
      ~L"""
      <svg width="400" height="400" style="margin-left: 25%; background-color: #eeeeee">
        <defs>
          <g id="cell">
            <rect width="10" height="10" x="1" y="1" style="fill:green;" />
          </g>
        </defs>

        <%= for c <- @cells do %>
          <use href="#cell" x="<%= x(c) %>" y="<%= y(c) %>"/>
        <%= end %>
      </svg>
      """
  end

  defp x({x,_y}), do: (x-1)*10
  defp y({_x,y}), do: (y-1)*10
end
