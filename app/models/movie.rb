class Movie < ApplicationRecord
  has_many :movie_genres
  has_many :genres, through: :movie_genres
  belongs_to :production_company

  # validation
  validates :title, uniqueness: true
  validates :title, :year, :duration, :description, :average_vote, presence: true
  validates :year, :duration, numericality: { only_integer: true }
  validates :average_vote, numericality: true

  def genres_list
    genres.map(&:name).join(", ")
  end
end
