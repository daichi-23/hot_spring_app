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

  describe "ユーザー詳細画面の表示・リンクのテスト" do
    let(:user) { create(:user) }
    let!(:onsen) { create(:onsen, user: user) }
    let!(:onsen_2) { create(:onsen, :onsen_2, user: user) }
    before do
      sign_in user
      visit user_path(user.id)
    end

    it "プロフィールが表示されていること" do
      expect(page).to have_content user.name
      expect(page).to have_content user.introduction
    end

    it "プロフィール編集ページへのリンクが表示されていること" do
      expect(page).to have_content "編集"
    end

    it "編集リンクのクリックでページが遷移すること" do
      click_on "編集"
      expect(current_path).to eq edit_user_path(user.id)
    end

    it "温泉情報が表示されていること" do
      within ".onsen-list" do
        expect(page).to have_content onsen.onsen_name
        expect(page).to have_content onsen.address
        expect(page).to have_content onsen.onsen_introduction
      end
    end

    it "温泉が更新が新しい順に並んでいること" do 
      expect(page.text).to match %r{#{onsen_2.onsen_name}[\s\S]*#{onsen.onsen_name}}
    end
    
    it "温泉名のクリックでページが遷移すること" do
      within ".onsen-list" do
        click_on onsen.onsen_name
      end
      expect(current_path).to eq onsen_path(onsen.id)
    end
  end
end
