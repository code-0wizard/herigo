class Country < ApplicationRecord
  has_many :heritages
  belongs_to :continent

  def self.create_countries
    file_path = Rails.root.join('db', 'countries.json')
    countries = JSON.parse(File.read(file_path))

    countries.each do |country|
      Country.create(name: country['name'], continent_id: country['continent_id'])
    end
  end
end
