class Review < ApplicationRecord
  belongs_to :heritage
  belongs_to :user
  has_many_attached :review_images
  validates :content,      presence: { message: '入力されていません' }, 
                           length: { maximum: 140, message: '140文字以下で入力してください' }
  validates :review_images, content_type: { in: %w[image/jpeg image/gif image/png], message: "不正なフォーマットです" },
                           size: { less_than: 5.megabytes, message: "5MB以上の画像は添付できません" }
  validate :image_count_limit

  private

    def image_count_limit
      if review_images.count > 4
        errors.add(:review_images, "画像は5枚以上添付できません")
      end
    end
end
