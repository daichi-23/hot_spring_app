require 'rails_helper'

RSpec.describe Collection, type: :model do
  before do
    user = create(:user)
    onsen = create(:onsen)
    @collection = build(:collection, user_id: user.id, onsen_id: onsen.id)
  end

  describe "行った温泉リスト" do
    context "追加できる時" do
      it "user_idとonsen_idがあれば追加できること" do
        expect(@collection).to be_valid
      end
    end

    context "追加できない時" do
      it "user_idが空の場合追加できないこと" do
        @collection.user_id = nil
        @collection.valid?
        expect(@collection.errors.full_messages).to include "Userを入力してください"
      end
      
      it "onsen_idが空の場合追加できないこと" do
        @collection.onsen_id = nil
        @collection.valid?
        expect(@collection.errors.full_messages).to include "Onsenを入力してください"
      end
    end
  end
end
