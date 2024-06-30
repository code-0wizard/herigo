require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'アカウント有効化' do
    let(:user) { FactoryBot.create(:user) }
    let(:mail) { UserMailer.account_activation(user) }

    it "「アカウント有効化」というタイトルで送信されること" do
      expect(mail.subject).to eq('アカウント有効化')
    end

    it '送信先がユーザーのメールアドレス宛であること' do
      expect(mail.to).to eq([user.email])
    end

    it '送信元が「from@example.com」であること' do
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'メール本文にユーザ名が表示されていること' do
      expect(mail.html_part.body.to_s).to include(user.name)
    end

    it 'メール本文にユーザのactivation_tokenが表示されていること' do
      user.activation_token = User.new_token
      activation_url = edit_account_activation_url(user.activation_token, email: user.email)
      expect(mail.html_part.body.to_s).to include(activation_url)
    end

  end
end
