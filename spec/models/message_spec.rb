require 'rails_helper'

describe Message do
  describe '#create' do

    it "is valid with a content" do
      message = build(:message)
      expect(message).to be_valid
    end

    it "is invalid without a content" do
      message = build(:message, content: nil)
      message.valid?
      expect(message.errors[:content]).to include("メッセージを入力してください")
    end

    it "is invalid without a user_id" do
      message = build(:message, user_id: nil)
      message.valid?
      expect(message.errors[:user_id]).to include("不正な送信です")
    end

    it "is invalid without a group_id" do
      message = build(:message, group_id: nil)
      message.valid?
      expect(message.errors[:group_id]).to include("不正な送信です")
    end

  end
end
