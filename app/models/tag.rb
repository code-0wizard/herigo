class Tag < ApplicationRecord
  has_many :heritage_tags, dependent: :destroy
  has_many :heritages, through: :heritage_tags

  # タグ名をDBに登録
  def self.create_tags
    file_path = Rails.root.join('db', 'tags.json')
    tags = JSON.parse(File.read(file_path))
    tags.each do |tag|
      Tag.create(name: tag['name'])
    end
  end
end
