require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    driven_by(:rack_test)
  end

  scenario '無効な値の場合、ユーザーは新規登録されない' do
    visit new_user_path
    fill_in 'user[name]', with:''
    fill_in 'user[email]', with:'test@test.com'
    fill_in 'user[password]', with:'password123'
    fill_in 'user[password_confirmation]', with:'password123'

    expect {
      click_button '会員登録'
    }.to_not change(User, :count)
  end

  scenario '有効な値の場合、ユーザーは新規登録される' do
    visit new_user_path
    fill_in 'user[name]', with:'テストユーザー'
    fill_in 'user[email]', with:'test@test.com'
    fill_in 'user[password]', with:'password123'
    fill_in 'user[password_confirmation]', with:'password123'

    expect {
      click_button '会員登録'
    }.to change(User, :count).by 1
  end
end
