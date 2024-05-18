class Heritage < ApplicationRecord
  belongs_to :country
  has_many :reviews, dependent: :destroy
  has_many :heritage_likes, dependent: :destroy
  has_many :likers, through: :heritage_likes, source: :user
end
