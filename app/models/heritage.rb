class Heritage < ApplicationRecord
  belongs_to :country
  has_one :heritage_first_charm, dependent: :destroy
  has_one :heritage_second_charm, dependent: :destroy
  has_one :heritage_third_charm, dependent: :destroy
  has_one :heritage_fourth_charm, dependent: :destroy
  has_many :heritage_charms, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :heritage_likes, dependent: :destroy
  has_many :likers, through: :heritage_likes, source: :user
  has_many_attached :images
  has_many :heritage_tags, dependent: :destroy
  has_many :tags, through: :heritage_tags, source: :tag
end
