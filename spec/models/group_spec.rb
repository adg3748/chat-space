require 'rails_helper'

describe Group do
  describe '#create' do

    it 'is valid with a name' do
      group = build(:group)
      expect(group).to be_valid
    end

    it "is invalid without a name" do
      group = build(:group, name: "")
      group.valid?
      expect(group.errors[:name]).to include("1文字以上8文字以内で入力してください")
    end

    it "is invalid due to too_long name" do
      group = build(:group, name: "000000000")
      group.valid?
      expect(group.errors[:name]).to include("1文字以上8文字以内で入力してください")
    end

  end
end
