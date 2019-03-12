defmodule TicketApi.Tc do
  @moduledoc """
  The Tc context.
  """

  import Ecto.Query, warn: false
  alias TicketApi.Repo

  alias TicketApi.Tc.TicketCount

  @doc """
  Returns the list of ticket_counts.

  ## Examples

      iex> list_ticket_counts()
      [%TicketCount{}, ...]

  """
  def list_ticket_counts do
    Repo.all(TicketCount)
  end

  @doc """
  Gets a single ticket_count.

  Raises `Ecto.NoResultsError` if the Ticket count does not exist.

  ## Examples

      iex> get_ticket_count!(123)
      %TicketCount{}

      iex> get_ticket_count!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ticket_count!(id), do: Repo.get!(TicketCount, id)

  @doc """
  Creates a ticket_count.

  ## Examples

      iex> create_ticket_count(%{field: value})
      {:ok, %TicketCount{}}

      iex> create_ticket_count(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ticket_count(attrs \\ %{}) do
    %TicketCount{}
    |> TicketCount.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ticket_count.

  ## Examples

      iex> update_ticket_count(ticket_count, %{field: new_value})
      {:ok, %TicketCount{}}

      iex> update_ticket_count(ticket_count, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ticket_count(%TicketCount{} = ticket_count, attrs) do
    ticket_count
    |> TicketCount.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a TicketCount.

  ## Examples

      iex> delete_ticket_count(ticket_count)
      {:ok, %TicketCount{}}

      iex> delete_ticket_count(ticket_count)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ticket_count(%TicketCount{} = ticket_count) do
    Repo.delete(ticket_count)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ticket_count changes.

  ## Examples

      iex> change_ticket_count(ticket_count)
      %Ecto.Changeset{source: %TicketCount{}}

  """
  def change_ticket_count(%TicketCount{} = ticket_count) do
    TicketCount.changeset(ticket_count, %{})
  end
end
