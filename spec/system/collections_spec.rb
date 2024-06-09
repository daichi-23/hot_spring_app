require 'rails_helper'

RSpec.describe "Collections", type: :system do

  describe "行った温泉リスト" do
    let(:user) { create(:user) }
    let!(:onsen) { create(:onsen) }

    it "ユーザーが投稿を追加・解除できること" do
      sign_in onsen.user

      visit onsens_path

      within ".onsen-body" do
        expect{
          find('i.collection-btn').click
        }.to change { Collection.count }.by(1)
      end

      within ".onsen-body" do
        expect{
          find('i.collection-btn').click
        }.to change { Collection.count }.by(-1)
      end
    end

    it "ログインしていない場合、ログインページに移動すること" do
      visit onsens_path

      within ".onsen-body" do
        find('i.collection-btn').click
      end

      expect(current_path).to eq new_user_session_path
    end
  end
end
