class Review < ApplicationRecord
  belongs_to :heritage
  belongs_to :user
  has_one_attached :review_image
  validates :content,       presence: { message: '入力されていません' }, 
                         length: { maximum: 140, message: '140文字以下で入力してください' }
  validates :review_image, content_type: { in: %w[image/jpeg image/gif image/png], message: "不正なフォーマットです" },
                         size: { less_than: 5.megabytes, message: "5MB以上の画像は添付できません" }
end
