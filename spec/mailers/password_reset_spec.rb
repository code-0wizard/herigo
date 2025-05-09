require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'パスワード再登録' do
    let(:user) { FactoryBot.create(:user) }
    let(:mail) { UserMailer.password_reset(user) }

    before do
      user.reset_token = User.new_token
    end

    it "「パスワード再登録」というタイトルで送信されること" do
      expect(mail.subject).to eq('パスワード再登録')
    end

    it '送信先がユーザーのメールアドレス宛であること' do
      expect(mail.to).to eq([user.email])
    end

    it '送信元が「from@example.com」であること' do
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'メール本文にURLが含まれること' do
      password_reset_url = edit_password_reset_url(user.reset_token, email: user.email)
      expect(mail.html_part.body.to_s).to include(password_reset_url)
    end
  end
end
