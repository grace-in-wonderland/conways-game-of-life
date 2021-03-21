defmodule ConwaysGameOfLifeWeb.LifeLive do
  use ConwaysGameOfLifeWeb, :live_view

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

      <%= live_component(
          @socket,
          ConwaysGameOfLifeWeb.Cells,
          cells: @alivecells) %>
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
end
