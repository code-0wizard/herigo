class Heritage < ApplicationRecord
  belongs_to :country
  has_many :reviews
  has_one_attached :heritage_image
end
