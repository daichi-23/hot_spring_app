require 'rails_helper'

RSpec.describe Favorite, type: :model do
  before do
    user = create(:user)
    onsen = create(:onsen)
    @favorite = build(:favorite, user_id: user.id, onsen_id: onsen.id)
  end

  describe "行きたい温泉リスト" do
    context "追加できる時" do
      it "user_idとonsen_idがあれば追加できること" do
        expect(@favorite).to be_valid
      end
    end

    context "追加できない時" do
      it "user_idが空の場合追加できないこと" do
        @favorite.user_id = nil
        @favorite.valid?
        expect(@favorite.errors.full_messages).to include "Userを入力してください"
      end
      
      it "onsen_idが空の場合追加できないこと" do
        @favorite.onsen_id = nil
        @favorite.valid?
        expect(@favorite.errors.full_messages).to include "Onsenを入力してください"
      end
    end
  end
end