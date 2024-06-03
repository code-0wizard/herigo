class Continent < ApplicationRecord
  has_many :countries
  has_one_attached :image

  def self.create_continents
    file_path = Rails.root.join('db', 'continents.json')
    continents = JSON.parse(File.read(file_path))
    continents.each do |continent|
      Continent.create(name: continent['name'])
    end
  end
end
