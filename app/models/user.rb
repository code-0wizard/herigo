class User < ApplicationRecord
  validates :name, presence: { message: 'ユーザー名欄は必須です' }, 
                   length: { maximum: 20, message: 'ユーザー名欄は20文字以下で入力してください' }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: { message: 'メールアドレス欄は必須です' }, 
                    format: { with: VALID_EMAIL_REGEX, message: 'メールアドレス欄は正しいメールアドレスを入力してください' },
                    uniqueness: { message: 'このメールアドレスは登録済みです' }
  has_secure_password validations: false
  VALID_PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/
  validates :password, presence: { message: 'パスワード欄は必須です' },
                       format: { with: VALID_PASSWORD_REGEX, message: 'パスワード欄には、半角英数字のみ(各1文字以上) で入力してください' },
                       length: { in: 8..20, message: 'パスワード欄は8～20桁で入力してください' }
  validates :password_confirmation, comparison: { equal_to: :password, message: 'パスワード再入力欄がパスワード欄と一致しません' }
end
