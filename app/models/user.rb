class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :like_reviews, through: :likes, source: :review
  has_many :heritage_likes, dependent: :destroy
  has_many :heritages, through: :heritage_likes, source: :heritage
  has_many :active_relationships,  class_name: 'Relationship',
                                   foreign_key: 'follower_id',
                                   dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  attr_accessor :remember_token, :activation_token, :reset_token, :email_reset_token, :new_email

  before_create :create_activation_digest
  has_one_attached :profile_image
  has_secure_password validations: false

  VALID_PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name,                  presence: { message: 'ユーザー名欄は必須です' },
                                    length: { maximum: 10, message: 'ユーザー名欄は10文字以下で入力してください' }
  validates :email,                 presence: { message: 'メールアドレス欄は必須です' },
                                    format: { with: VALID_EMAIL_REGEX, message: 'メールアドレス欄は正しいメールアドレスを入力してください' },
                                    uniqueness: { message: 'このメールアドレスは登録済みです' }
  validates :password,              presence: { message: 'パスワード欄は必須です' },
                                    format: { with: VALID_PASSWORD_REGEX, message: 'パスワード欄には、半角英数字のみ(各1文字以上) で入力してください' },
                                    length: { in: 8..20, message: 'パスワード欄は8～20桁で入力してください' },
                                    allow_nil: true
  validates :password_confirmation, comparison: { equal_to: :password, message: 'パスワード再入力欄がパスワード欄と一致しません' },
                                    allow_nil: true
  validates :profile_image,         content_type: { in: %w[image/jpeg image/gif image/png], message: '有効なフォーマットではありません' },
                                    size: { less_than: 5.megabytes, message: '5MB以上の画像は添付できません' }

  # 渡された文字列のハッシュ値を返す
  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost:)
  end

  # ランダムなトークンを返す
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続的セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def session_token
    remember_digest || remember
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def create_email_reset_digest(new_email)
    self.email_reset_token = User.new_token
    self.new_email = new_email
    update_attribute(:email_reset_digest,  User.digest(email_reset_token))
    update_attribute(:email_reset_sent_at, Time.zone.now)
  end

  def send_email_reset_email
    UserMailer.email_reset(self).deliver_now
  end

  def email_reset_expired?
    email_reset_sent_at < 24.hours.ago
  end

  def follow(other_user)
    following << other_user unless self == other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def like_review(review)
    like_reviews << review unless review_liked?(review)
  end

  def unlike_review(review)
    like_reviews.delete(review)
  end

  def review_liked?(review)
    like_reviews.include?(review)
  end

  def like_heritage(heritage)
    heritages << heritage unless heritage_liked?(heritage)
  end

  def unlike_heritage(heritage)
    heritages.delete(heritage)
  end

  def heritage_liked?(heritage)
    heritages.include?(heritage)
  end

  private

  # 有効化トークンとダイジェストを作成および代入する
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
