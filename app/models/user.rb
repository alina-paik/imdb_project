class User < ApplicationRecord
  has_many :ratings

  validates :username, :email, presence: true
  validates :email, uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, length: { maximum: 20 }
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
end
