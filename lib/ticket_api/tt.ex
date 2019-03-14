defmodule TicketApi.Tt do
  @moduledoc """
  The Tt context.
  """

  import Ecto.Query, warn: false
  alias TicketApi.Repo

  alias TicketApi.Tt.TicketType
  alias TicketApi.Tc.TicketCount

  @doc """
  Returns the list of ticket_types.

  ## Examples

      iex> list_ticket_types()
      [%TicketType{}, ...]

  """
  def list_ticket_types do
    Repo.all(TicketType)
  end

  @doc """
  Gets a single ticket_type.

  Raises `Ecto.NoResultsError` if the Ticket type does not exist.

  ## Examples

      iex> get_ticket_type!(123)
      %TicketType{}

      iex> get_ticket_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ticket_type!(id), do: Repo.get!(TicketType, id)

  @doc """
  Creates a ticket_type.

  ## Examples

      iex> create_ticket_type(%{field: value})
      {:ok, %TicketType{}}

      iex> create_ticket_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ticket_type(attrs \\ %{}) do
    %TicketType{}
    |> TicketType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ticket_type.

  ## Examples

      iex> update_ticket_type(ticket_type, %{field: new_value})
      {:ok, %TicketType{}}

      iex> update_ticket_type(ticket_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ticket_type(%TicketType{} = ticket_type, attrs) do
    ticket_type
    |> TicketType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a TicketType.

  ## Examples

      iex> delete_ticket_type(ticket_type)
      {:ok, %TicketType{}}

      iex> delete_ticket_type(ticket_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ticket_type(%TicketType{} = ticket_type) do
    Repo.delete(ticket_type)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ticket_type changes.

  ## Examples

      iex> change_ticket_type(ticket_type)
      %Ecto.Changeset{source: %TicketType{}}

  """
  def change_ticket_type(%TicketType{} = ticket_type) do
    TicketType.changeset(ticket_type, %{})
  end

  def validate_type(ticket_type_id, count, event_id) do
    case get_ticket_type!(ticket_type_id) do
      nil ->
        {:error, :not_found_type}
      ticket_type ->
        validate_count(ticket_type, count, event_id)
    end
  end

  defp validate_count(ticket_type, count, event_id) do
    query = from tc in TicketCount,
          where: tc.event_id == ^event_id and tc.ticket_type_id == ^ticket_type.id
    case Repo.one(query) do
      nil ->
        {:error, :not_found_count}
      ticket_count ->
        can_subtract?(ticket_count, count, ticket_type.t_type)
    end
  end

  defp can_subtract?(count_left, size, t_type) do
    case t_type do
      "multiple" ->
        if size < count_left.size_left do
          if rem(size,2) == 0 do
            {:ok, count_left}
          else
            {:error, :wrong_count}
          end
        else
          {:error, :too_many}
        end
      "altogether" ->
        if size < count_left.size_left do
          {:ok, count_left}
        else
          {:error, :too_many}
        end
      "avoid_one" ->
        if count_left.size_left - size > 1 do
          {:ok, count_left}
        else
          {:error, :too_many}
        end
    end
  end
end
