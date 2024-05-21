require 'rails_helper'

RSpec.describe "Onsens", type: :system do
  describe "ホーム画面の表示・リンクのテスト" do
    let!(:onsen) { create(:onsen) }
    before do
      visit onsens_path
    end

    it "温泉情報が表示されていること" do
      within ".onsen-body" do
        expect(page).to have_content onsen.onsen_name
        expect(page).to have_content onsen.address
        expect(page).to have_content onsen.onsen_introduction
      end
    end
    
    it "温泉名のクリックでページが遷移すること" do
      within ".onsen-body" do
        click_on onsen.onsen_name
      end
      expect(current_path).to eq onsen_path(onsen.id)
    end
  end

  describe "温泉詳細画面の表示・リンクのテスト" do
    let(:user) { create(:user) }
    let!(:onsen) { create(:onsen, user: user) }
    before do
      sign_in onsen.user
      visit onsen_path(onsen.id)
    end

    it "温泉情報が表示されていること" do
      expect(page).to have_content onsen.onsen_name
      expect(page).to have_content onsen.address
      expect(page).to have_content onsen.onsen_introduction
    end

    it "温泉編集ページへのリンクが表示されていること" do
      expect(page).to have_content "編集"
    end

    it "編集リンクのクリックでページが遷移すること" do
      click_on "編集"
      
      expect(current_path).to eq edit_onsen_path(onsen.id)
    end

    it "投稿者ページへのリンクが表示されていること" do
      expect(page).to have_content user.name
    end

    it "投稿者名のクリックでページが遷移すること" do
      click_on user.name
      
      expect(current_path).to eq user_path(user.id)
    end
  end
end
