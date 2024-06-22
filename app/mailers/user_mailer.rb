class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: 'アカウント有効化'
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'パスワード再登録'
  end

  def email_reset(user)
    @user = user
    mail to: user.new_email, subject: 'メールアドレスの再登録'
  end
end
