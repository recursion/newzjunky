defmodule Newzjunky.Config do
  @api_key "2905def9d7a94180b85df8110eaa5071"

  def url do
    "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=" <> @api_key
  end
end
