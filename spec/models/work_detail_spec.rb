# frozen_string_literal: true

require "rails_helper"

RSpec.describe WorkDetail, type: :model do
  describe "ワーク詳細を作成する" do
    it "有効な情報を登録すればワーク詳細を作成できること" do
      expect(FactoryBot.create(:work_detail)).to be_valid  # comment.valid? が true になればパスする
    end
  end
end
