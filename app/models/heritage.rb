class Heritage < ApplicationRecord
  belongs_to :country
  has_many :reviews, dependent: :destroy
end
