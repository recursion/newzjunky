defmodule NewzjunkyWeb.Router do
  use NewzjunkyWeb, :router
  alias Newzjunky.Guardian

  pipeline :api do
    plug CORSPlug
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end

  scope "/api/v1", NewzjunkyWeb do
    pipe_through :api
    post "/sign_up", UserController, :create
    post "/sign_in", UserController, :sign_in
    options "/sign_in", UserController, :nothing
    options "/sign_up", UserController, :nothing
  end

  scope "/api/v1", NewzjunkyWeb do
    pipe_through [:api, :jwt_authenticated]
    get "/my_user", UserController, :show
  end

  scope "/api/v1/stories", NewzjunkyWeb do
    pipe_through :api
    get "/", StoryController, :index
  end
end
