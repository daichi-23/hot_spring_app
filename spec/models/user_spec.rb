require 'rails_helper'

RSpec.describe User, type: :model do
  

  describe "ユーザー新規登録" do
    before do
      @user = build(:user)
    end

    context "ユーザー登録ができる時" do
      it "全ての値が正しく入力されていれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context "ユーザー登録ができない時" do
      it "nameが空だと登録できないこと" do
        @user.name = " "
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end

      it "emailが空だと登録できないこと" do
        @user.email = " "
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
      end

      it "passwordが空だと登録できないこと" do
        @user.password = " "
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end

      it "重複したemailが存在すると登録できないこと" do
        @user.save
        another_user = build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("メールアドレスはすでに存在します")
      end

      it "nameが50文字より多いと登録できないこと" do
        @user.name = "x" * 51
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は50文字以内で入力してください")
      end
    end
  end

  describe "ログイン" do
    before do
      @user = create(:user)
    end

    context "ログインができる時" do
      it "introductionが300文字以内であれば登録できること" do
        @user.introduction = "x" * 300
        @user.valid?
        expect(@user).to be_valid
      end
    end

    context "ログインができない時" do
      it "introductionが300文字より多いと登録できないこと" do
        @user.introduction = "x" * 301
        @user.valid?
        expect(@user.errors.full_messages).to include("自己紹介は300文字以内で入力してください")
      end
    end
  end
end
