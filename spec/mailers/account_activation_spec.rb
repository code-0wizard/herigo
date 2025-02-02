require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'アカウント有効化' do
    let(:user) { FactoryBot.create(:user) }
    let(:mail) { UserMailer.account_activation(user) }

    before do
      user.activation_token = User.new_token
    end

    it "「アカウント有効化」というタイトルで送信されること" do
      expect(mail.subject).to eq('アカウント有効化')
    end

    it '送信先がユーザーのメールアドレス宛であること' do
      expect(mail.to).to eq([user.email])
    end

    it '送信元が「from@example.com」であること' do
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'メール本文にユーザー名が表示されること' do
      expect(mail.html_part.body.to_s).to include(user.name)
    end

    it 'メール本文にURLが含まれること' do
      activation_url = edit_account_activation_url(user.activation_token, email: user.email)
      expect(mail.html_part.body.to_s).to include(activation_url)
    end
  end
end
