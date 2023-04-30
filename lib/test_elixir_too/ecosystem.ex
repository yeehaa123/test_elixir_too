defmodule TestElixirToo.EcoSystem do
  alias TestElixirToo.Organism

  def initialize(max) do
    populate_organisms(max)
    |> Enum.flat_map(& &1)
    |> populate()
  end

  def update(organisms) do
    organisms
    |> populate
  end

  def populate(organisms) do
    organisms
    |> Enum.map(&Organism.random(&1, 15))
  end

  def spawn_organism(organisms) do
    index =
      (length(organisms) - 1)
      |> :rand.uniform()

    organisms
    |> List.update_at(index, &Organism.toggle(&1))
  end

  defp populate_organisms(max) do
    0..max
    |> Enum.map(&populate_row(max, &1))
  end

  defp populate_row(max, row_index) do
    0..max
    |> Enum.map(
      &%Organism{
        row_index: row_index,
        column_index: &1,
        active: false,
        direction: Organism.determine_direction()
      }
    )
  end
end
