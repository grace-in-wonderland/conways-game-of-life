defmodule ConwaysGameOfLifeWeb.LifeLive do
  #use Phoenix.LiveView
  use ConwaysGameOfLifeWeb, :live_view
  import Phoenix.HTML, only: [raw: 1]

  def mount(_params, _session, socket) do
    { :ok, assign(socket, alivecells: Grid.new ) }
  end

  def render(assigns) do
    ~L"""
      <button phx-click="next_turn">Next</button>

      <svg width="400" height="400" style="margin-left: 25%; background-color: #eeeeee">
        <defs>
          <g id="cell">
            <rect width="10" height="10" x="1" y="1" style="fill:green;" />
          </g>
        </defs>

        <%= for c <- @alivecells do %>
          <use href="#cell" x="<%= x(c) %>" y="<%= y(c) %>"/>
        <%= end %>

      </svg>
    """
  end

  def handle_event("next_turn", _params, socket ) do
    current_cells = socket.assigns.alivecells
    {:noreply, assign(socket, alivecells: (Grid.turn(current_cells)) )}
  end

  defp x({x,_y}), do: (x-1)*10
  defp y({_x,y}), do: (y-1)*10
end
