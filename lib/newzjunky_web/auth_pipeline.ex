defmodule Newzjunky.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :Newzjunky,
    module: Newzjunky.Guardian,
    error_handler: Newzjunky.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
