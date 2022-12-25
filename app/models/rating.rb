class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :user_id, :movie_id, :grade, presence: true
  validates :user_id, uniqueness: { scope: :movie_id }
  validates :grade, numericality: { only_integer: true},
                    inclusion: {in: 1..10}
end
