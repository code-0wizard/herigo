require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  describe "#create" do
    let(:user) { FactoryBot.create(:user) }

    # context "when email is empty" do
    #   it "contains 'メールアドレスが入力されていません' in flash[:danger]" do

    #   end

    #   it "render new" do
        
    #   end

    #   it "ステータスが「unprocessable_entity」である" do
        
    #   end
    # end

    # context "when email is not empty" do
    #   context "when email already exists" do
    #     it "エラーメッセージを表示する" do
    #       post :create, params: { password_reset: { email: "invalid@example.com" } }
    #       expect(flash[:danger]).to be_present
    #     end
  
    #     it "newテンプレートを再描画する" do
    #       post :create, params: { password_reset: { email: "invalid@example.com" } }
    #       expect(response).to render_template('new')
    #     end

    #     it "ステータスが「unprocessable_entity」である" do
        
    #     end
    #   end

    #   context "when email does not exist yet" do
    #     it "reset_digestの値がレコード内に存在すること" do
    #       expect {
    #         post :create, params: { password_reset: { email: user.email } }
    #       }.to change { user.reload.reset_digest }.from(nil)
    #     end

    #     it "reset_sent_atに今の日付が入っていること" do

    #     end
    
    #     it "パスワード再登録のメールを送信する" do
    #       expect {
    #         post :create, params: { password_reset: { email: user.email } }
    #       }.to change { ActionMailer::Base.deliveries.size }.by(1)
    #     end

    #     it "contains 'パスワード再登録のメールを送信しました' in flash[:info]" do

    #     end
    
    #     it "ルートURLにリダイレクトする" do
    #       post :create, params: { password_reset: { email: user.email } }
    #       expect(response).to redirect_to(root_url)
    #     end
    #   end
    # end
  end

  describe "#update" do
    let(:user) { FactoryBot.create(:user, :with_reset_digest) }

    # context "無効なパスワードの場合" do
    #   it "エラーメッセージを表示する" do
    #     patch :update, params: { id: user.reset_token, email: user.email, user: { password: "", password_confirmation: "" } }
    #     expect(user.errors[:password]).to include("パスワードが入力されていません")
    #   end

    #   it "editテンプレートを再描画する" do
    #     patch :update, params: { id: user.reset_token, email: user.email, user: { password: "", password_confirmation: "" } }
    #     expect(response).to render_template('edit')
    #   end
    # end

    # context "有効なパスワードの場合" do
    #   it "パスワードを更新する" do
    #     patch :update, params: { id: user.reset_token, email: user.email, user: { password: "newpassword", password_confirmation: "newpassword" } }
    #     expect(user.reload.authenticate("newpassword")).to be_truthy
    #   end

    #   it "セッションをリセットする" do
    #     patch :update, params: { id: user.reset_token, email: user.email, user: { password: "newpassword", password_confirmation: "newpassword" } }
    #     expect(session[:user_id]).to be_nil
    #   end

    #   it "ユーザーページにリダイレクトする" do
    #     patch :update, params: { id: user.reset_token, email: user.email, user: { password: "newpassword", password_confirmation: "newpassword" } }
    #     expect(response).to redirect_to(user)
    #   end
  end

end
