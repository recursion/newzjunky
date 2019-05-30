defmodule Newzjunky.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  @doc """
      Logger.info("Populating stories")
      HTTPoison.start()
      r = HTTPoison.get!(Newzjunky.Config.url())
      body = Jason.decode!(r.body)

      stories =
        body["articles"]
        |> Enum.map(fn story ->
          %Story{
            title: story["title"],
            url: story["url"],
            urlToImage: story["urlToImage"],
            description: story["description"],
            content: story["content"],
            author: story["author"]
          }
        end)

      render(conn, "index.json", stories: stories)
  """
  def get_stories do
    HTTPoison.start()
    r = HTTPoison.get!(Newzjunky.Config.url())
    body = Jason.decode!(r.body)

    body["articles"]
  end

  def get_first_story do
    hd(get_stories())
  end

  def load_stories do
    get_stories()
    |> Enum.each fn s ->
      Newzjunky.Stories.create_story(s)
      {:ok}
    end
  end

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Newzjunky.Repo,
      # Start the endpoint when the application starts
      NewzjunkyWeb.Endpoint
      # Starts a worker by calling: Newzjunky.Worker.start_link(arg)
      # {Newzjunky.Worker, arg},
    ]

    :ets.new(:newzjunky, [:named_table])

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Newzjunky.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    NewzjunkyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
