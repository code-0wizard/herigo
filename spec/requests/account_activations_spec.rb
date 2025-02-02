require 'rails_helper'
include SessionsHelper

RSpec.describe 'AccountActivations', type: :request do
  describe '/account_activations/{id}/edit' do
    before do
      post users_path, params: { user: { name: 'テストユーザー',
                                         email: 'user@example.com',
                                         password: 'password123',
                                         password_confirmation: 'password123' } }
      @user = controller.instance_variable_get('@user')
    end

    context 'トークンとemailが有効な場合' do
      it 'activateされること' do
        get edit_account_activation_path(@user.activation_token, email: @user.email)
        @user.reload
        expect(@user).to be_activated
      end
 
      # TODO:ログイン状態にならない
      it 'ログイン状態になること' do
        get edit_account_activation_path(@user.activation_token, email: @user.email)
        expect(logged_in?).to be_truthy
      end
    end

    
    context 'トークンとemailが無効な場合' do
      # TODO:エラーになる
      it '有効化トークンが不正ならログイン状態にならないこと' do
        get edit_account_activation_path('invalid token', email: @user.email)
        expect(logged_in?).to be_falsey
      end
 
      # TODO:エラーになる
      it 'メールアドレスが不正ならログイン状態にならないこと' do
        get edit_account_activation_path(@user.activation_token, email: 'invalid@test.com')
        expect(logged_in?).to be_falsey
      end
    end
  end
end
