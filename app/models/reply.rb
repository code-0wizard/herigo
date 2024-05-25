class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :review
  has_many_attached :reply_images
  validates :content,      presence: { message: '入力されていません' }, 
                           length: { maximum: 1000, message: '1000文字以下で入力してください' }
  validates :reply_images, content_type: { in: %w[image/jpeg image/gif image/png], message: "不正なフォーマットです" },
                            size: { less_than: 5.megabytes, message: "5MB以上の画像は添付できません" }
  validate :image_count_limit

private

  def image_count_limit
    if reply_images.count > 4
    errors.add(:reply_images, "画像は5枚以上添付できません")
    end
  end
end
