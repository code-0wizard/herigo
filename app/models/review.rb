class Review < ApplicationRecord
  belongs_to :heritage
  belongs_to :user
end
