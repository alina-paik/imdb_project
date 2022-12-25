class Movie < ApplicationRecord
  has_many :ratings
  has_and_belongs_to_many :categories

  validates :title, :title_image, :description, presence: true
  validates :description, length: { maximum: 1000}

  def average_rating
     Rating.where(movie_id: id).average(:grade)
  end
end
