require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /users #create" do
    context '無効な値の場合' do
      it 'ユーザーは登録されないこと' do
        expect {
          post users_path, params: { user: { name: '',
                                            email: 'user@example.com',
                                            password: 'password123',
                                            password_confirmation: 'password123' } }
        }.to_not change(User, :count)
      end
    end

    context '有効な値の場合' do
      let(:user_params) { { user: { name: 'テストユーザー',
                                    email: 'user@example.com',
                                    password: 'password123',
                                    password_confirmation: 'password123' } } }
   
      it '登録されること' do
        expect {
          post users_path, params: user_params
        }.to change(User, :count).by 1
      end

      before do
        ActionMailer::Base.deliveries.clear
      end

      it 'メールが1件存在すること' do
        post users_path, params: user_params
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end

      it '登録時点ではactivateされていないこと' do
        post users_path, params: user_params
        expect(User.last).to_not be_activated
      end

    end
  end
end
