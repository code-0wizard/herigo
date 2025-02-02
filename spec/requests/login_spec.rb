require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "POST /login" do
    before do
      FactoryBot.create(:user)
      FactoryBot.create(:not-activated-user)
    end

    context '有効なログイン情報の場合' do
      it 'forwarding_urlが設定されている場合はそのURLにリダイレクトされること' do
        session[:forwarding_url] = user_path(user)
        post login_path, params: { session: { email: user.email, password: 'password' } }
        expect(response).to redirect_to(user_path(user))
        # expect(logged_in?).to be_truthy
      end

      it 'forwarding_urlが設定されていない場合はルートURLにリダイレクトされること' do
        post login_path, params: { session: { email: user.email, password: 'password' } }
        expect(response).to redirect_to(root_url)
        # expect(logged_in?).to be_truthy
      end
    end

    context '無効なログイン情報の場合' do
      it 'ログインに失敗し、エラーメッセージが表示されること' do
        post login_path, params: { session: { email: user.email, password: 'wrong_password' } }
        expect(session[:user_id]).to be_nil
        expect(response.body).to include('メールアドレスとパスワードが一致しません')
        expect(response).to render_template('new')
      end
    end

    context 'アカウントが有効化されていない場合' do
      before do
        user.update_attribute(:activated, false)
      end

      it 'アカウントが有効化されていないメッセージが表示されること' do
        post login_path, params: { session: { email: user.email, password: 'password' } }
        expect(response).to render_template('not_activated')
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context '「remember me」が選択された場合' do
      it 'remember_tokenが設定されること' do
        post login_path, params: { session: { email: user.email, password: 'password', remember_me: '1' } }
        expect(cookies[:remember_token]).not_to be_nil
      end
    end

    context '「remember me」が選択されなかった場合' do
      it 'remember_tokenが設定されないこと' do
        post login_path, params: { session: { email: user.email, password: 'password', remember_me: '0' } }
        expect(cookies[:remember_token]).to be_nil
      end
    end
  end
end
