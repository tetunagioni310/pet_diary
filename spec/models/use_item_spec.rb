# frozen_string_literal: true

require "rails_helper"

RSpec.describe UseItem, type: :model do
  describe "使用アイテム登録" do
    before do
      @use_item = create(:use_item)
    end

    it "有効な使用アイテムの場合は保存されるか" do
      expect(@use_item).to be_valid  # pet.valid? が true になればパスする
    end

    it "sheetのアイテムを選択して保存されるか" do
      @use_sheet_item = create(:use_item, :use_sheet_item)
      expect(@use_sheet_item).to be_valid
    end

    it "pieceのアイテムを選択して保存されるか" do
      @use_piece_item = create(:use_item, :use_piece_item)
      expect(@use_piece_item).to be_valid
    end

    it "amount_usedが空欄の場合、保存されない" do
      @use_item.amount_used = nil
      @use_item.valid?
      expect(@use_item.errors.full_messages).to include("使用量を入力してください")
    end
  end
end
