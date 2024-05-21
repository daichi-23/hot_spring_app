require 'rails_helper'

RSpec.describe Onsen, type: :model do

  describe "温泉登録" do
    before do
      @onsen = build(:onsen)
      @user = create(:user)
      sign_in @user
    end

    context "温泉登録ができる時" do
      it "全ての値が正しく入力されていれば登録できる" do
        expect(@onsen).to be_valid
      end
    end

    context "温泉登録ができない時" do
      it "onsen_nameが空だと登録できないこと" do
        @onsen.onsen_name = " "
        @onsen.valid?
        expect(@onsen.errors.full_messages).to include("温泉名を入力してください")
      end

      it "onsen_introductionが空だと登録できないこと" do
        @onsen.onsen_introduction = " "
        @onsen.valid?
        expect(@onsen.errors.full_messages).to include("温泉詳細を入力してください")
      end

      it "addressが空だと登録できないこと" do
        @onsen.address = " "
        @onsen.valid?
        expect(@onsen.errors.full_messages).to include("所在地を入力してください")
      end

      it "onsen_nameが50文字より多いと登録できないこと" do
        @onsen.onsen_name = "x" * 51
        @onsen.valid?
        expect(@onsen.errors.full_messages).to include("温泉名は50文字以内で入力してください")
      end

      it "onsen_introductionが300文字より多いと登録できないこと" do
        @onsen.onsen_introduction = "x" * 301
        @onsen.valid?
        expect(@onsen.errors.full_messages).to include("温泉詳細は300文字以内で入力してください")
      end

      it "onsen_introductionが5文字より少ないと登録できないこと" do
        @onsen.onsen_introduction = "xxxx"
        @onsen.valid?
        expect(@onsen.errors.full_messages).to include("温泉詳細は5文字以上で入力してください")
      end
      
      it "addressが100文字より多いと登録できないこと" do
        @onsen.address = "x" * 101
        @onsen.valid?
        expect(@onsen.errors.full_messages).to include("所在地は100文字以内で入力してください")
      end
    end
  end
end
