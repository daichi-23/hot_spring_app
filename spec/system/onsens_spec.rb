require 'rails_helper'

RSpec.describe "Onsens", type: :system do
  describe "ホーム画面の表示・リンクのテスト" do
    let(:onsen) { create(:onsen) }
    let!(:onsen_2) { create(:onsen, :onsen_2) }
    let!(:favorite) { create(:favorite, onsen_id: onsen.id) }
    before do
      visit onsens_path
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

    it "ログインしている場合、温泉名のクリックでページが遷移すること" do
      sign_in onsen.user
      within ".onsen-list" do
        click_on onsen.onsen_name
      end
      expect(current_path).to eq onsen_path(onsen.id)
    end

    it "ログインしていない場合、温泉名のクリックでログイン画面に遷移すること" do
      within ".onsen-list" do
        click_on onsen.onsen_name
      end
      expect(current_path).to eq user_session_path
    end

    it "温泉表示を人気順に変更ができること" do
      click_on "人気順"

      expect(page.text).to match %r{#{onsen.onsen_name}[\s\S]*#{onsen_2.onsen_name}}
    end
  end

  describe "温泉詳細画面の表示・リンクのテスト" do
    let(:user) { create(:user) }
    let(:onsen) { create(:onsen, user: user) }
    let!(:collection) { create(:collection, user_id: user.id, onsen_id: onsen.id) }
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
      within ".flat-navi" do
        expect(page).to have_content "編集"
      end
    end

    it "編集リンクのクリックでページが遷移すること" do
      within ".flat-navi" do
        click_on "編集"
        expect(current_path).to eq edit_onsen_path(onsen.id)
      end
    end

    it "投稿者ページへのリンクが表示されていること" do
      within ".posted-by" do
        expect(page).to have_content user.name
      end
    end

    it "投稿者名のクリックでページが遷移すること" do
      within ".posted-by" do
        click_on user.name
        expect(current_path).to eq user_path(user.id)
      end
    end

    it "コメント投稿ページへのリンクが表示されていること" do
      within ".comment-header" do
        expect(page).to have_content "感想を投稿・編集"
      end
    end

    it "コメント投稿ページへのリンクをクリックで、コメント投稿ページへ遷移すること" do
      within ".comment-header" do
        click_on "感想を投稿・編集"
        expect(current_path).to eq edit_onsen_collection_path(onsen.id, collection.id)
      end
    end

    it "コメント投稿者名のクリックでページが遷移すること" do
      within ".comment" do
        click_on user.name
        expect(current_path).to eq user_path(user.id)
      end
    end

    it "コメントが表示されていること" do
      expect(page).to have_content collection.comment
    end
  end
end
