Mix.install([
  {:httpoison, "~> 1.8"},
  {:floki, "~> 0.30"}
])

defmodule WikiScraper do
  def scrape_wiki_page(url) do
    HTTPoison.get!(url).body
    |> Floki.parse_document!()
    |> Floki.find("h1.firstHeading")
    |> Floki.text()
    |> IO.inspect(label: "Title")
  end
end

WikiScraper.scrape_wiki_page("https://en.wikipedia.org/wiki/List_of_Neon_films")
