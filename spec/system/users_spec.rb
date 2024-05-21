require 'rails_helper'

RSpec.describe "Users", type: :system do

  describe "ユーザー新規登録" do
    before do
      @user = build(:user)
    end

    context "ユーザー登録ができる時" do
      it "全ての値が正しく入力されていれば新規登録でき、トップページに移動すること" do
        visit root_path

        expect(page).to have_content("新規登録")

        visit new_user_registration_path

        fill_in "user[name]", with: @user.name
        fill_in "user[email]", with: @user.email
        fill_in "user[password]", with: @user.password
        fill_in "user[password_confirmation]", with: @user.password_confirmation
        
        expect{
          find('input[name="commit"]').click
        }.to change { User.count }.by(1)

        expect(current_path).to eq root_path
      end
    end

    context "ユーザー登録ができない時" do
      it "正しい値が入力されていない場合新規登録できず、新規登録画面に戻ること" do
        visit root_path

        expect(page).to have_content("新規登録")

        visit new_user_registration_path

        fill_in "user[name]", with: " "
        fill_in "user[email]", with: " "
        fill_in "user[password]", with: " "
        fill_in "user[password_confirmation]", with: " "

        expect{
          find('input[name="commit"]').click
        }.to change { User.count }.by(0)

        expect(current_path).to eq('/users')
      end
    end
  end

  describe "ログイン" do
    before do
      @user = create(:user)
    end

    context "ログインができる時" do
      it "保存されているユーザーの情報と合致すればログインでき、トップページに移動すること" do
        visit root_path

        expect(page).to have_content("ログイン")

        visit user_session_path
        
        fill_in "user[email]", with: @user.email
        fill_in "user[password]", with: @user.password
        
        find('input[name="commit"]').click

        expect(current_path).to eq root_path
      end
    end

    context "ログインができない時" do
      it "保存されているユーザーの情報と合致しない場合ログインできず、ログイン画面に戻ること" do
        visit root_path

        expect(page).to have_content("ログイン")

        visit user_session_path
        
        fill_in "user[email]", with: " "
        fill_in "user[password]", with: " "
        
        find('input[name="commit"]').click

        expect(current_path).to eq new_user_session_path
      end
    end
  end

  describe "ゲストログイン" do
    it "ゲストログインをクリックで、ゲストユーザとしてログインし、トップページに戻ること" do
      visit root_path

      expect(page).to have_content("ゲストログイン")

      click_on "ゲストログイン"

      expect(current_path).to eq root_path
      expect(page).to have_content("ログアウト")
    end
  end
end
