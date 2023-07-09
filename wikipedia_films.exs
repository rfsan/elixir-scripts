Mix.install([
  {:httpoison, "~> 1.8"},
  {:floki, "~> 0.30"}
])

defmodule WikiScraper do
  def download_wiki_page(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{body: body}} ->
        body
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect("HTTP Error: #{reason}")
    end
  end

  def parse_html(html) do
    {:ok, document} = Floki.parse_document(html)
    title_element = Floki.find(document, "h1.firstHeading")
    title = Floki.text(title_element)
    title
  end

  def scrape_wiki_page(url) do
    html = download_wiki_page(url)
    IO.puts(html)
    title = parse_html(html)
    IO.puts("Title of the page: #{title}")
  end
end

WikiScraper.scrape_wiki_page("https://en.wikipedia.org/wiki/List_of_Neon_films")
