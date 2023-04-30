defmodule TestElixirToo.Organism do
  defstruct row_index: 0, column_index: 0, active: false, direction: :right

  def random(organism, percentage) do
    Map.update(organism, :active, false, fn _ -> random_bool(percentage) end)
  end

  def activate(organism) do
    Map.replace(organism, :active, true)
  end

  def toggle(organism) do
    Map.update(organism, :active, false, &(!&1))
  end

  defp random_bool(percentage) do
    random_number = :rand.uniform(100)
    random_number < percentage
  end

  def determine_direction() do
    directions = [:up, :down, :left, :right]
    Enum.random(directions)
  end
end
