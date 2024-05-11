class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  before_create :create_activation_digest
  validates :name, presence: { message: 'ユーザー名欄は必須です' }, 
                   length: { maximum: 20, message: 'ユーザー名欄は20文字以下で入力してください' }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: { message: 'メールアドレス欄は必須です' }, 
                    format: { with: VALID_EMAIL_REGEX, message: 'メールアドレス欄は正しいメールアドレスを入力してください' },
                    uniqueness: { message: 'このメールアドレスは登録済みです' }
  has_secure_password validations: false
  VALID_PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/
  validates :password, presence: { message: 'パスワード欄は必須です' }, on: [:create],
                       format: { with: VALID_PASSWORD_REGEX, message: 'パスワード欄には、半角英数字のみ(各1文字以上) で入力してください' },
                       length: { in: 8..20, message: 'パスワード欄は8～20桁で入力してください' }
  validates :password_confirmation, comparison: { equal_to: :password, message: 'パスワード再入力欄がパスワード欄と一致しません' }, on: [:create]

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
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

  private

  # 有効化トークンとダイジェストを作成および代入する
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
