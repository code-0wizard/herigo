class HeritageCharm < ApplicationRecord
  belongs_to :heritage
  has_one_attached :main_image
  has_one_attached :sub_image
end
