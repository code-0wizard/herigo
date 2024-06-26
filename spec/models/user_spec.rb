require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    let(:user) { FactoryBot.create(:user) }

    describe 'nameのバリデーション' do
      it 'userが有効であること' do
        expect(user).to be_valid
      end

      it 'nilの時、任意のエラーメッセージが表示されること' do
        user.name = nil
        user.valid?
        expect(user.errors[:name]).to include('ユーザー名欄は必須です')
      end

      it '空の時、任意のエラーメッセージが表示されること' do
        user.name = ' '
        user.valid?
        expect(user.errors[:name]).to include('ユーザー名欄は必須です')
      end

      context 'when name is longer than 10 characters' do
        it 'is invalid' do
          user.name = 'a' * 11
          user.valid?
          expect(user.errors[:name]).to include('ユーザー名欄は10文字以下で入力してください')
        end
      end
      context 'when name is exactly 10 characters' do
        it 'is valid' do
          user.name = 'a' * 10
          user.valid?
          expect(user).to be_valid
        end
      end
    end

    describe 'email validations' do
      context 'when email is nil' do
        it 'is invalid' do
          user.email = nil
          user.valid?
          expect(user.errors[:email]).to include('メールアドレス欄は必須です')
        end
      end
      context 'when email is blank' do
        it 'is invalid' do
          user.email = ' '
          user.valid?
          expect(user.errors[:email]).to include('メールアドレス欄は必須です')
        end
      end

      context 'when duplicate email' do
        it 'does not allow' do
          user
          duplicate_email_user = FactoryBot.build(:user)
          duplicate_email_user.valid?
          expect(duplicate_email_user.errors[:email]).to include('このメールアドレスは登録済みです')
        end
      end

      context 'when email is incorrect format' do
        it 'does not allow' do
          user.email = 'hogehoge'
          user.valid?
          expect(user.errors[:email]).to include('メールアドレス欄は正しいメールアドレスを入力してください')
        end
      end
    end

    describe 'password validations' do
      context 'when password is blank' do
        it 'is invalid' do
          user.password = ' '
          user.valid?
          expect(user.errors[:password]).to include('パスワード欄は必須です')
        end
      end

      context 'when password is shorter than 8 characters' do
        it 'is invalid' do
          user.password = 'pass123'
          user.valid?
          expect(user.errors[:password]).to include('パスワード欄は8～20桁で入力してください')
        end
      end
      context 'when password is longer than 20 characters' do
        it 'is invalid' do
          user.password = 'p' * 20 + '1'
          user.valid?
          expect(user.errors[:password]).to include('パスワード欄は8～20桁で入力してください')
        end
      end

      context 'when password does not contain numbers' do
        it 'is invalid' do
          user.password = 'password'
          user.valid?
          expect(user.errors[:password]).to include('パスワード欄には、半角英数字のみ(各1文字以上) で入力してください')
        end
      end
      context 'when password contains only numbers' do
        it 'is invalid' do
          user.password = '12341234'
          user.valid?
          expect(user.errors[:password]).to include('パスワード欄には、半角英数字のみ(各1文字以上) で入力してください')
        end
      end
    end

    describe 'password_confirmation validations' do
      context 'when password_confirmation does not match password' do
        it 'is invalid' do
          user.password_confirmation = 'different123'
          user.valid?
          expect(user.errors[:password_confirmation]).to include('パスワード再入力欄がパスワード欄と一致しません')
        end
      end
    end
  end
end
