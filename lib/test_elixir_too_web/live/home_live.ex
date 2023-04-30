defmodule TestElixirTooWeb.HomeLive do
  use TestElixirTooWeb, :live_view
  alias TestElixirToo.EcoSystem

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(100, self(), :tick)
    end

    size = 4

    organisms =
      EcoSystem.initialize(size - 1)
      |> EcoSystem.populate()

    socket = assign(socket, organisms: organisms, size: size)
    {:ok, socket}
  end

  def render(assigns) do
    assigns = assign(assigns, :base_class, "organism")

    ~H"""
    <style>
      .ecosystem {
      display: grid;
      width: 100%;
      max-width: 500px;
      margin: 0 auto;
      grid-template-columns: repeat(<%= @size %>, <%= 100/@size %>%);
      grid-gap: <%= 50/@size %>px;
      }

      .organism {
      background: pink;
      height: <%= 500/@size %>px;
      font-size: 20px;
      }
      .organism.active.left {
      background: red;
      }
      .organism.active.right {
      background: black;
      }
      .organism.active.up {
      background: white;
      }
      .organism.active.down {
      background: grey;
      }
    </style>
    <div class="ecosystem">
      <div
        :for={organism <- @organisms}
        class={
          if(organism.active,
            do: @base_class <> " " <> Atom.to_string(organism.direction) <> " " <> "active",
            else: @base_class <> " " <> Atom.to_string(organism.direction)
          )
        }
      >
      </div>
    </div>
    """
  end

  def handle_info(:tick, socket) do
    socket = update(socket, :organisms, &EcoSystem.spawn_organism(&1))
    {:noreply, socket}
  end
end
