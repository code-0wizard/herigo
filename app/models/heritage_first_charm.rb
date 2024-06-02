class HeritageFirstCharm < ApplicationRecord
  belongs_to :heritage
  has_one_attached :image
end
