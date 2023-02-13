# frozen_string_literal: true

require "rails_helper"

RSpec.describe FavoriteItemDetail, type: :model do
  describe "お気に入りアイテム詳細登録" do
    it "有効なお気に入りアイテムの場合は保存されるか" do
      expect(FactoryBot.create(:favorite_item_detail)).to be_valid  # pet.valid? が true になればパスする
    end
  end
end
