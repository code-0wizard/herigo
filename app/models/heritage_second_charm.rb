class HeritageSecondCharm < ApplicationRecord
  belongs_to :heritage
  has_one_attached :image
end
