class UserMailerPreview < ActionMailer::Preview
  def account_activation
    UserMailer.account_activation
  end

  def password_reset
    UserMailer.password_reset
  end

  def email_reset
    user = User.first
    user.email_reset_token = User.new_token
    user.new_email = "aaa@aaa.com"
    UserMailer.email_reset(user)
  end
end
