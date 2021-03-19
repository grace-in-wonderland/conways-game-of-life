defmodule ConwaysGameOfLifeWeb.LifeLive do
  #use Phoenix.LiveView
  use ConwaysGameOfLifeWeb, :live_view
  import Phoenix.HTML, only: [raw: 1]

  def mount(_params, _session, socket) do
    if connected?(socket), do: :timer.send_interval(250, :tick)
    { :ok, assign(socket, alivecells: Grid.new ) }
  end

  def render(assigns) do
    ~L"""
      <div class="patterns">
        <button phx-click="add_blinker">Blinker</button>
        <button phx-click="add_pulsar">Pulsar</button>
        <button phx-click="add_glider">Glider</button>
        <button phx-click="add_spaceship">Space Ship</button>
      </div>

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

  def handle_info(:tick, socket) do
    current_cells = socket.assigns.alivecells
    {:noreply, assign(socket, alivecells: (Grid.turn(current_cells)) )}
  end

  def handle_event("add_blinker", _params, socket) do
    current_cells = socket.assigns.alivecells
    blinker_cells = Grid.blinker({15, 15})
    {:noreply, assign(socket, alivecells: current_cells ++ blinker_cells)}
  end

  def handle_event("add_pulsar", _params, socket) do
    current_cells = socket.assigns.alivecells
    pulsar_cells = Grid.pulsar({5, 25})
    {:noreply, assign(socket, alivecells: current_cells ++ pulsar_cells)}
  end

  def handle_event("add_glider", _params, socket) do
    current_cells = socket.assigns.alivecells
    loaf_cells = Grid.glider({5, 35})
    {:noreply, assign(socket, alivecells: current_cells ++ loaf_cells)}
  end

  def handle_event("add_spaceship", _params, socket) do
    current_cells = socket.assigns.alivecells
    spaceship_cells = Grid.lightweight_space_ship({30, 2})
    {:noreply, assign(socket, alivecells: current_cells ++ spaceship_cells)}
  end

  defp x({x,_y}), do: (x-1)*10
  defp y({_x,y}), do: (y-1)*10
end
