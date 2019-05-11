defmodule Newzjunky.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Newzjunky.Accounts.User

  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do
    field :email, :string
    field :password_hash, :string
    # Virtual Fields
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    # Remove hash, add pw + pw confirmation
    |> cast(attrs, [:email, :password, :password_confirmation])
    # Remove hash, add pw + pw confirmation
    |> validate_required([:email, :password, :password_confirmation])
    # Check that email is valid
    |> validate_format(:email, ~r/@/)
    # Check that password length is >= 8 
    |> validate_length(:password, min: 8)
    # Check that password === password_confirmation
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, hashpwsalt(pass))

      _ ->
        changeset
    end
  end
end