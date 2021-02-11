require "csv"

Page.delete_all
Movie.delete_all
ProductionCompany.delete_all

Page.create(
  title:     "About us",
  content:   "This is all about the creators.",
  permalink: "about_us"
)
Page.create(
  title:     "Second Post",
  content:   "This is the second Page. It was written after the About Us page",
  permalink: "data_info"
)

filename = Rails.root.join("db/top_movies.csv")

csv_data = File.read(filename)

movies = CSV.parse(csv_data, headers: true, encoding: "utf-8")

movies.each do |m|
  production_company = ProductionCompany.find_or_create_by(name: m["production_company"])

  if production_company && production_company.valid?
    # create a movie based on production company
    movie = production_company.movies.create(
      title:        m["original_title"],
      year:         m["year"],
      duration:     m["duration"],
      description:  m["description"],
      average_vote: m["avg_vote"]
    )

    puts "Invalid movie #{m['original_title']}" unless movie&.valid?
  else
    puts "Invalid Production Company #{m['production_company']} for movie #{m['original_title']}"
  end
end
