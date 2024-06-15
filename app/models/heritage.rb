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
  has_many :heritage_tags, dependent: :destroy
  has_many :tags, through: :heritage_tags, source: :tag
  has_one_attached :pc_image
  has_one_attached :mobile_image
  has_many_attached :slideshow_images

  def self.create_heritages
    file_path = Rails.root.join('db', 'heritages.json')
    data = JSON.parse(File.read(file_path))
      pc_img_path = Rails.root.join("app/assets/images/tests/top_pc.png")
      mobile_img_path = Rails.root.join("app/assets/images/tests/top_mobile.png")
      main_img_path = Rails.root.join("app/assets/images/tests/main.png")
      sub_img_path = Rails.root.join("app/assets/images/tests/sub.png")
    ActiveRecord::Base.transaction do
      begin
        data.each do |item|
          heritage_data = item["heritage"]
          tag_ids = item["heritage_tags"]
          heritage_charms_data = item["heritage_charms"]

          heritage = Heritage.create!(heritage_data)
          heritage.pc_image.attach(io: File.open(pc_img_path), filename: 'top_pc.png', content_type: 'image/png')
          heritage.mobile_image.attach(io: File.open(mobile_img_path), filename: 'top_mobile.png', content_type: 'image/png')
          4.times do
            heritage.slideshow_images.attach(io: File.open(sub_img_path), filename: 'sub.png', content_type: 'image/png')
          end

          tag_ids.each do |tag_id|
            HeritageTag.create!(heritage_id: heritage.id, tag_id: tag_id)
          end

          heritage_charms_data.each do |charm_data|
            heritage_charm = heritage.heritage_charms.build(charm_data)
            if charm_data["order"] == 1 || charm_data["order"] == 2
              heritage_charm.main_image.attach(io: File.open(main_img_path), filename: 'main.png', content_type: 'image/png')
              heritage_charm.sub_image.attach(io: File.open(sub_img_path), filename: 'sub.png', content_type: 'image/png')
            else
              heritage_charm.main_image.attach(io: File.open(sub_img_path), filename: 'sub.png', content_type: 'image/png')
            end
            heritage_charm.save!
          end
        end
      rescue ActiveRecord::RecordInvalid => e
        puts "Error: #{e.message}"
        raise ActiveRecord::Rollback
      end
    end
  end
end
