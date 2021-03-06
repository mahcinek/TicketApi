defmodule TicketApi.Auth do
  @moduledoc """
  The Auth context.
  """

  import Ecto.Query, warn: false
  alias TicketApi.Repo

  alias TicketApi.Auth.User
  alias TicketApi.Guardian
  alias TicketApi.Tick.Ticket
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

    @doc """
  Returns a token for given user. Token works for one day.
  Currently there is no endpoint for refreshing tokens/getting new ones for
  exisitng user. In normal application that should be implemented.

  ## Examples

      iex> create_token(user)
      {:ok, "asddsadsasazxc"}

  """
  def create_token(%User{} = user) do
    case Guardian.encode_and_sign(user, %{}, ttl: {1, :day}) do
      {:ok, token, _claims} ->
        {:ok, token}
      _ ->
        {:error, ""}
    end
  end

  def token_sign_in(email, password) do
    case email_password_auth(email, password) do
      {:ok, user} ->
        Guardian.encode_and_sign(user)
      _ ->
        {:error, :unauthorized}
    end
  end
  @doc """
  Returns user and status for given token.

  ## Examples

      iex> authenticate(token)
      {:ok, user}

  """
  def authenticate(token) do

    case Guardian.resource_from_token(token) do
      {:ok, resource, _claims} ->
        {:ok, resource}
      _ ->
        {:error, false}
    end
  end

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def get_ticket(user, ticket_id) do
    u_id = user.id
    query = from t in Ticket, where: t.user_id == ^u_id and t.id == ^ticket_id
    case Repo.one(query) do
      nil ->
        {:error, :not_found}
      ticket ->
        {:ok, ticket: ticket}
    end
  end

  def list_tickets(user) do
    u_id = user.id
    query = from t in Ticket, where: t.user_id == ^u_id
    Repo.all(query)
  end

  defp verify_password(password, %User{} = user) when is_binary(password) do
    if checkpw(password, user.password_hash) do
      {:ok, user}
    else
      {:error, :invalid_password}
    end
  end

  defp email_password_auth(email, password) when is_binary(email) and is_binary(password) do
    with {:ok, user} <- get_by_email(email),
    do: verify_password(password, user)
  end

  defp get_by_email(email) when is_binary(email) do
    case Repo.get_by(User, email: email) do
      nil ->
        dummy_checkpw()
        {:error, "Login error."}
      user ->
        {:ok, user}
    end
  end
end
